variable region {
  description = "Tenancy region to provision resources in"
}
variable tenancy_ocid {
  description = "OCID of tenancy to provision resources in"
}
variable compartment_ocid {
  description = "OCID of compartment to provision resources in"
}
variable availability_domain_name {
  description = "Availability Domain to provision the compute instance in"
  default = null
}
variable instance_shape {
  description = "Shape of Jenkins VM compute instance to provision and install Jenkins in"
  default = "VM.Standard.E3.Flex"
}

variable instance_os {
  description = "Operating system of Jenkins VM compute instance"
  default     = "Oracle Linux"
}
variable linux_os_version {
  description = "Operating system version"
  default     = "7.9"
}

locals {
  availability_domain_name   = var.availability_domain_name != null ? var.availability_domain_name : data.oci_identity_availability_domains.ADs.availability_domains[0].name
  instance_shape             = var.instance_shape
  compute_flexible_shapes    = ["VM.Standard.E3.Flex","VM.Standard.E4.Flex"]
  is_flexible_instance_shape = contains(local.compute_flexible_shapes, local.instance_shape)
}