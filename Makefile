removenonazure:
	for platform in aws baremetal gcp libvirt openstack ovirt vsphere ; do \
		rm -rf pkg/asset/cluster/$$platform/ \
		       pkg/asset/installconfig/$$platform/ \
			   pkg/asset/machines/$$platform/ \
			   pkg/asset/manifests/$$platform/ \
			   pkg/asset/cluster/$$platform/ \
			   pkg/asset/types/$$platform/ \
			   pkg/asset/quota/$$platform/ \
			   pkg/destroy/$$platform/ \
   			   pkg/tfvars/$$platform/ \
  			   pkg/quota/$$platform/ \
			   ; \
	done
	rm -rf cmd/openshift-install/ \
		  pkg/destroy/ \
		  pkg/terraform/
