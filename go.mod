module github.com/openshift/installer

go 1.14

require (
	github.com/Azure/azure-sdk-for-go v43.2.0+incompatible
	github.com/Azure/go-autorest/autorest v0.10.0
	github.com/Azure/go-autorest/autorest/azure/auth v0.4.1
	github.com/Azure/go-autorest/autorest/to v0.3.1-0.20191028180845-3492b2aff503
	github.com/Netflix/go-expect v0.0.0-20190729225929-0e00d9168667 // indirect
	github.com/apparentlymart/go-cidr v1.0.1
	github.com/clarketm/json v1.14.1
	github.com/containers/image v3.0.2+incompatible
	github.com/coreos/ignition/v2 v2.3.0
	github.com/coreos/vcontext v0.0.0-20200225161404-ee043618d38d // indirect
	github.com/fatih/color v1.9.0 // indirect
	github.com/ghodss/yaml v1.0.1-0.20190212211648-25d852aebe32
	github.com/go-playground/validator/v10 v10.2.0
	github.com/golang/mock v1.4.3
	github.com/google/uuid v1.1.1
	github.com/h2non/filetype v1.0.12
	github.com/hinshun/vt10x v0.0.0-20180809195222-d55458df857c // indirect
	github.com/kr/text v0.2.0 // indirect
	github.com/libvirt/libvirt-go v5.10.0+incompatible
	github.com/mattn/go-colorable v0.1.6 // indirect
	github.com/metal3-io/baremetal-operator v0.0.0
	github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e // indirect
	github.com/openshift/api v3.9.1-0.20191111211345-a27ff30ebf09+incompatible
	github.com/openshift/cluster-api v0.0.0-20191129101638-b09907ac6668
	github.com/openshift/machine-config-operator v0.0.0-00010101000000-000000000000
	github.com/pborman/uuid v1.2.0
	github.com/pkg/errors v0.9.1
	github.com/pkg/sftp v1.10.1
	github.com/prometheus/client_golang v1.7.1
	github.com/prometheus/common v0.10.0
	github.com/shurcooL/vfsgen v0.0.0-20181202132449-6a9ea43bcacd
	github.com/sirupsen/logrus v1.6.0
	github.com/spf13/cobra v1.0.0
	github.com/stretchr/testify v1.6.1
	github.com/ulikunitz/xz v0.5.7
	github.com/vincent-petithory/dataurl v0.0.0-20191104211930-d1553a71de50
	github.com/vmware/govmomi v0.22.2
	golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9
	golang.org/x/lint v0.0.0-20200302205851-738671d3881b
	golang.org/x/sys v0.0.0-20200615200032-f1bc736245b1
	golang.org/x/text v0.3.3 // indirect
	google.golang.org/appengine v1.6.6 // indirect
	gopkg.in/AlecAivazis/survey.v1 v1.8.9-0.20200217094205-6773bdf39b7f
	gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f // indirect
	honnef.co/go/tools v0.0.1-2020.1.3 // indirect
	k8s.io/api v0.19.0
	k8s.io/apiextensions-apiserver v0.19.0
	k8s.io/apimachinery v0.19.0
	k8s.io/client-go v12.0.0+incompatible
	k8s.io/utils v0.0.0-20200729134348-d5654de09c73
	sigs.k8s.io/cluster-api-provider-azure v0.0.0
	sigs.k8s.io/controller-tools v0.3.1-0.20200617211605-651903477185
)

replace (
	bitbucket.org/ww/goautoneg => github.com/munnerz/goautoneg v0.0.0-20120707110453-a547fc61f48d // 404 on bitbucket.org/ww/goautoneg
	github.com/Azure/go-autorest => github.com/tombuildsstuff/go-autorest v14.0.1-0.20200416184303-d4e299a3c04a+incompatible
	github.com/Azure/go-autorest/autorest => github.com/tombuildsstuff/go-autorest/autorest v0.10.1-0.20200416184303-d4e299a3c04a
	github.com/Azure/go-autorest/autorest/azure/auth => github.com/tombuildsstuff/go-autorest/autorest/azure/auth v0.4.3-0.20200416184303-d4e299a3c04a
	github.com/go-log/log => github.com/go-log/log v0.1.1-0.20181211034820-a514cf01a3eb // Pinned by MCO
	github.com/googleapis/gnostic => github.com/googleapis/gnostic v0.4.0
	github.com/hashicorp/terraform => github.com/openshift/terraform v0.12.20-openshift-4 // Pin to fork with deduplicated rpc types v0.12.20-openshift-4
	github.com/hashicorp/terraform-plugin-sdk => github.com/openshift/hashicorp-terraform-plugin-sdk v1.14.0-openshift // Pin to fork with public rpc types
	github.com/metal3-io/baremetal-operator => github.com/openshift/baremetal-operator v0.0.0-20200715132148-0f91f62a41fe // Use OpenShift fork
	github.com/metal3-io/cluster-api-provider-baremetal => github.com/openshift/cluster-api-provider-baremetal v0.0.0-20190821174549-a2a477909c1d // Pin OpenShift fork
	github.com/openshift/api => github.com/openshift/api v0.0.0-20200930075302-db52bc4ef99f // Pin API
	github.com/openshift/client-go => github.com/openshift/client-go v0.0.0-20200929181438-91d71ef2122c // Pin client-go
	github.com/openshift/machine-config-operator => github.com/openshift/machine-config-operator v0.0.1-0.20201026223526-4f29aba0ccd1 // Pin MCO so it doesn't get downgraded
	github.com/terraform-providers/terraform-provider-aws => github.com/openshift/terraform-provider-aws v1.60.1-0.20200630224953-76d1fb4e5699 // Pin to openshift fork with tag v2.67.0-openshift
	github.com/terraform-providers/terraform-provider-azurerm => github.com/openshift/terraform-provider-azurerm v1.40.1-0.20200707062554-97ea089cc12a // release-2.17.0 branch
	github.com/terraform-providers/terraform-provider-ignition/v2 => github.com/community-terraform-providers/terraform-provider-ignition/v2 v2.1.0
	github.com/terraform-providers/terraform-provider-vsphere => github.com/openshift/terraform-provider-vsphere v1.18.1-openshift-2
	github.com/vmware/govmomi => github.com/vmware/govmomi v0.22.2-0.20200420222347-5fceac570f29
	k8s.io/api => k8s.io/api v0.17.1 // Replaced by MCO/CRI-O
	k8s.io/apiextensions-apiserver => k8s.io/apiextensions-apiserver v0.17.1 // Replaced by MCO/CRI-O
	k8s.io/apimachinery => k8s.io/apimachinery v0.17.1 // Replaced by MCO/CRI-O
	k8s.io/apiserver => k8s.io/apiserver v0.17.1 // Replaced by MCO/CRI-O
	k8s.io/cli-runtime => k8s.io/cli-runtime v0.17.1 // Replaced by MCO/CRI-O
	k8s.io/client-go => k8s.io/client-go v0.17.1 // Replaced by MCO/CRI-O
	k8s.io/cloud-provider => k8s.io/cloud-provider v0.17.1 // Replaced by MCO/CRI-O
	k8s.io/cluster-bootstrap => k8s.io/cluster-bootstrap v0.17.1 // Replaced by MCO/CRI-O
	k8s.io/code-generator => k8s.io/code-generator v0.17.1 // Replaced by MCO/CRI-O
	k8s.io/component-base => k8s.io/component-base v0.17.1 // Replaced by MCO/CRI-O
	k8s.io/cri-api => k8s.io/cri-api v0.17.1 // Replaced by MCO/CRI-O
	k8s.io/csi-translation-lib => k8s.io/csi-translation-lib v0.17.1 // Replaced by MCO/CRI-O
	k8s.io/kube-aggregator => k8s.io/kube-aggregator v0.17.1 // Replaced by MCO/CRI-O
	k8s.io/kube-controller-manager => k8s.io/kube-controller-manager v0.17.1 // Replaced by MCO/CRI-O
	k8s.io/kube-proxy => k8s.io/kube-proxy v0.17.1 // Replaced by MCO/CRI-O
	k8s.io/kube-scheduler => k8s.io/kube-scheduler v0.17.1 // Replaced by MCO/CRI-O
	k8s.io/kubectl => k8s.io/kubectl v0.17.1 // Replaced by MCO/CRI-O
	k8s.io/kubelet => k8s.io/kubelet v0.17.1 // Replaced by MCO/CRI-O
	k8s.io/kubernetes => k8s.io/kubernetes v1.17.1 // Replaced by MCO/CRI-O
	k8s.io/legacy-cloud-providers => k8s.io/legacy-cloud-providers v0.17.1 // Replaced by MCO/CRI-O
	k8s.io/metrics => k8s.io/metrics v0.17.1 // Replaced by MCO/CRI-O
	k8s.io/sample-apiserver => k8s.io/sample-apiserver v0.17.1 // Replaced by MCO/CRI-O
	sigs.k8s.io/cluster-api-provider-aws => github.com/openshift/cluster-api-provider-aws v0.2.1-0.20200506073438-9d49428ff837 // Pin OpenShift fork
	sigs.k8s.io/cluster-api-provider-azure => github.com/openshift/cluster-api-provider-azure v0.1.0-alpha.3.0.20200120114645-8a9592f1f87b // Pin OpenShift fork
	sigs.k8s.io/cluster-api-provider-openstack => github.com/openshift/cluster-api-provider-openstack v0.0.0-20200526112135-319a35b2e38e // Pin OpenShift fork
)
