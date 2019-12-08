variable "bootstrap_dns" {
  type        = string
  default     = true
  description = "Whether to include DNS entries for the bootstrap node or not."
}

variable "ovirt_url" {
  type        = string
  description = "The oVirt engine URL"
}

variable "ovirt_username" {
  type        = string
  description = "The name of user to access oVirt engine API"
}

variable "ovirt_password" {
  type        = string
  description = "The plain password of user to access oVirt engine API"
}

variable "ovirt_cluster_id" {
  type        = string
  description = "The ID of oVirt's cluster"
}

variable "ovirt_storage_domain_id" {
  type        = string
  description = "The ID of oVirt's stoage domain for the template"
}

variable "openstack_base_image_name" {
  type        = string
  description = "Name of the base image to use for the nodes."
}

variable "openstack_base_image_local_file_path" {
  type        = string
  default     = ""
  description = "Local file path of the base image file to use for the nodes."
}