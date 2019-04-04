#####################################################################
##
##      Created 4/4/19 by icpadmin. for SingleServer
##
#####################################################################

terraform {
  required_version = "> 0.8.0"
}

provider "ibm" {
  softlayer_username = "${var.ibm_sl_username}"
  softlayer_api_key  = "${var.ibm_sl_api_key}"
  version = "~> 0.7"
}


data "ibm_security_group" "ICP_private" {
    name = "${var.ICP_private_name}"
}

data "ibm_security_group" "ICP_public" {
    name = "${var.ICP_public_name}"
}

resource "ibm_compute_vm_instance" "single_vm" {
  cores       = 8
  memory      = 16384
  domain      = "${var.single_vm_domain}"
  hostname    = "${var.single_vm_hostname}"
  datacenter  = "${var.single_vm_datacenter}"
  ssh_key_ids = ["${ibm_compute_ssh_key.auth.id}"]
  os_reference_code = "${var.single_vm_os_reference_code}"
  hourly_billing = true
  local_disk = "${var.local_disk}"
  disks = [100,350]
  private_security_group_ids = ["${data.ibm_security_group.ICP_private.id}"]
  public_security_group_ids = ["${data.ibm_security_group.ICP_public.id}"]
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
}

resource "ibm_compute_ssh_key" "auth" {
  label = "${var.ibm_ssh_key_name}"
  public_key = "${tls_private_key.ssh.public_key_openssh}"
}