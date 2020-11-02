package manifests

import (
	"fmt"
	"path/filepath"

	"github.com/ghodss/yaml"
	"github.com/pkg/errors"

	corev1 "k8s.io/api/core/v1"
	v1 "k8s.io/api/core/v1"
	rbacv1 "k8s.io/api/rbac/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"

	"github.com/openshift/installer/pkg/asset"
	"github.com/openshift/installer/pkg/asset/installconfig"
	"github.com/openshift/installer/pkg/asset/manifests/azure"
	azuretypes "github.com/openshift/installer/pkg/types/azure"
)

var (
	cloudProviderConfigFileName         = filepath.Join(manifestDir, "cloud-provider-config.yaml")
	aroCloudProviderRoleFileName        = filepath.Join(manifestDir, "aro-cloud-provider-secret-reader-role.yaml")
	aroCloudProviderRoleBindingFileName = filepath.Join(manifestDir, "aro-cloud-provider-secret-reader-rolebinding.yaml")
	aroCloudProviderSecretFileName      = filepath.Join(manifestDir, "aro-cloud-provider-secret.yaml")
)

const (
	cloudProviderConfigDataKey = "config"
)

// CloudProviderConfig generates the cloud-provider-config.yaml files.
type CloudProviderConfig struct {
	ConfigMap *corev1.ConfigMap
	FileList  []*asset.File
}

var _ asset.WritableAsset = (*CloudProviderConfig)(nil)

// Name returns a human friendly name for the asset.
func (*CloudProviderConfig) Name() string {
	return "Cloud Provider Config"
}

// Dependencies returns all of the dependencies directly needed to generate
// the asset.
func (*CloudProviderConfig) Dependencies() []asset.Asset {
	return []asset.Asset{
		&installconfig.PlatformCreds{},
		&installconfig.InstallConfig{},
		&installconfig.ClusterID{},
		// PlatformCredsCheck just checks the creds (and asks, if needed)
		// We do not actually use it in this asset directly, hence
		// it is put in the dependencies but not fetched in Generate
		&installconfig.PlatformCredsCheck{},
	}
}

// Generate generates the CloudProviderConfig.
func (cpc *CloudProviderConfig) Generate(dependencies asset.Parents) error {
	platformCreds := &installconfig.PlatformCreds{}
	installConfig := &installconfig.InstallConfig{}
	clusterID := &installconfig.ClusterID{}
	dependencies.Get(platformCreds, installConfig, clusterID)

	cm := &corev1.ConfigMap{
		TypeMeta: metav1.TypeMeta{
			APIVersion: corev1.SchemeGroupVersion.String(),
			Kind:       "ConfigMap",
		},
		ObjectMeta: metav1.ObjectMeta{
			Namespace: "openshift-config",
			Name:      "cloud-provider-config",
		},
		Data: map[string]string{},
	}

	switch installConfig.Config.Platform.Name() {
	case azuretypes.Name:
		session, err := installConfig.Azure.Session()
		if err != nil {
			return errors.Wrap(err, "could not get azure session")
		}

		nsg := fmt.Sprintf("%s-nsg", clusterID.InfraID)
		nrg := installConfig.Config.Azure.ClusterResourceGroupName(clusterID.InfraID)
		if installConfig.Config.Azure.NetworkResourceGroupName != "" {
			nrg = installConfig.Config.Azure.NetworkResourceGroupName
		}
		vnet := fmt.Sprintf("%s-vnet", clusterID.InfraID)
		if installConfig.Config.Azure.VirtualNetwork != "" {
			vnet = installConfig.Config.Azure.VirtualNetwork
		}
		subnet := fmt.Sprintf("%s-worker-subnet", clusterID.InfraID)
		if installConfig.Config.Azure.ComputeSubnet != "" {
			subnet = installConfig.Config.Azure.ComputeSubnet
		}
		azureConfig, err := azure.CloudProviderConfig{
			CloudName:                installConfig.Config.Azure.CloudName,
			ResourceGroupName:        installConfig.Config.Azure.ClusterResourceGroupName(clusterID.InfraID),
			GroupLocation:            installConfig.Config.Azure.Region,
			ResourcePrefix:           clusterID.InfraID,
			SubscriptionID:           session.Credentials.SubscriptionID,
			TenantID:                 session.Credentials.TenantID,
			NetworkResourceGroupName: nrg,
			NetworkSecurityGroupName: nsg,
			VirtualNetworkName:       vnet,
			SubnetName:               subnet,
			ARO:                      installConfig.Config.Azure.ARO,
		}.JSON()
		if err != nil {
			return errors.Wrap(err, "could not create cloud provider config")
		}
		cm.Data[cloudProviderConfigDataKey] = azureConfig
	default:
		return errors.New("invalid Platform")
	}

	cmData, err := yaml.Marshal(cm)
	if err != nil {
		return errors.Wrapf(err, "failed to create %s manifest", cpc.Name())
	}
	cpc.ConfigMap = cm
	cpc.FileList = []*asset.File{
		{
			Filename: cloudProviderConfigFileName,
			Data:     cmData,
		},
	}
	if installConfig.Config.Azure.ARO {
		for _, f := range []struct {
			filename string
			data     func(*installconfig.PlatformCreds) ([]byte, error)
		}{
			{
				filename: aroCloudProviderRoleFileName,
				data:     aroRole,
			},
			{
				filename: aroCloudProviderRoleBindingFileName,
				data:     aroRoleBinding,
			},
			{
				filename: aroCloudProviderSecretFileName,
				data:     aroSecret,
			},
		} {
			b, err := f.data(platformCreds)
			if err != nil {
				return errors.Wrapf(err, "failed to create %s manifest", cpc.Name())
			}

			cpc.FileList = append(cpc.FileList, &asset.File{
				Filename: f.filename,
				Data:     b,
			})
		}
	}
	return nil
}

// Files returns the files generated by the asset.
func (cpc *CloudProviderConfig) Files() []*asset.File {
	return cpc.FileList
}

// Load loads the already-rendered files back from disk.
func (cpc *CloudProviderConfig) Load(f asset.FileFetcher) (bool, error) {
	return false, nil
}

func aroRole(*installconfig.PlatformCreds) ([]byte, error) {
	return yaml.Marshal(&rbacv1.Role{
		TypeMeta: metav1.TypeMeta{
			Kind:       "Role",
			APIVersion: "rbac.authorization.k8s.io/v1",
		},
		ObjectMeta: metav1.ObjectMeta{
			Name:      "aro-cloud-provider-secret-reader",
			Namespace: "kube-system",
		},
		Rules: []rbacv1.PolicyRule{
			{
				Verbs:         []string{"get"},
				APIGroups:     []string{""},
				Resources:     []string{"secrets"},
				ResourceNames: []string{"azure-cloud-provider"},
			},
		},
	})
}

func aroRoleBinding(*installconfig.PlatformCreds) ([]byte, error) {
	return yaml.Marshal(&rbacv1.RoleBinding{
		TypeMeta: metav1.TypeMeta{
			Kind:       "RoleBinding",
			APIVersion: "rbac.authorization.k8s.io/v1",
		},
		ObjectMeta: metav1.ObjectMeta{
			Name:      "aro-cloud-provider-secret-read",
			Namespace: "kube-system",
		},
		Subjects: []rbacv1.Subject{
			{
				Kind:      "ServiceAccount",
				Name:      "azure-cloud-provider",
				Namespace: "kube-system",
			},
		},
		RoleRef: rbacv1.RoleRef{
			APIGroup: "rbac.authorization.k8s.io",
			Kind:     "Role",
			Name:     "aro-cloud-provider-secret-reader",
		},
	})
}

func aroSecret(platformCreds *installconfig.PlatformCreds) ([]byte, error) {
	// config is used to created compatible secret to trigger azure cloud
	// controller config merge behaviour
	// https://github.com/openshift/origin/blob/release-4.3/vendor/k8s.io/kubernetes/staging/src/k8s.io/legacy-cloud-providers/azure/azure_config.go#L82
	config := struct {
		AADClientID     string `json:"aadClientId" yaml:"aadClientId"`
		AADClientSecret string `json:"aadClientSecret" yaml:"aadClientSecret"`
	}{
		AADClientID:     platformCreds.Azure.ClientID,
		AADClientSecret: platformCreds.Azure.ClientSecret,
	}

	b, err := yaml.Marshal(config)
	if err != nil {
		return nil, err
	}

	return yaml.Marshal(&v1.Secret{
		TypeMeta: metav1.TypeMeta{
			Kind:       "Secret",
			APIVersion: corev1.SchemeGroupVersion.String(),
		},
		ObjectMeta: metav1.ObjectMeta{
			Name:      "azure-cloud-provider",
			Namespace: "kube-system",
		},
		Data: map[string][]byte{
			"cloud-config": b,
		},
		Type: v1.SecretTypeOpaque,
	})
}
