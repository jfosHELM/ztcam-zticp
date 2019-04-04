#####################################################################
##
##      Created 4/4/19 by icpadmin. for SingleServer
##
#####################################################################


variable "ibm_sl_username" {
  type = "string"
  description = "Generated"
}

variable "ibm_sl_api_key" {
  type = "string"
  description = "Generated"
}

variable "single_vm_domain" {
  type = "string"
  description = "The domain for the computing instance."
}

variable "single_vm_hostname" {
  type = "string"
  description = "The hostname for the computing instance."
}

variable "single_vm_datacenter" {
  type = "string"
  description = "The datacenter in which you want to provision the instance. NOTE: If dedicated_host_name or dedicated_host_id is provided then the datacenter should be same as the dedicated host datacenter."
}

variable "single_vm_os_reference_code" {
  type = "string"
  description = "Generated"
}

variable "ibm_ssh_key_name" {
  type = "list"
  description = "Generated"
}

variable "local_disk" {
  type = "string"
  description = "Generated"
  default = "false"
}

variable "ICP_private_name" {
  type = "list"
  description = "Generated"
}

variable "ICP_public_name" {
  type = "list"
  description = "Generated"
}

