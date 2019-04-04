#####################################################################
##
##      Created 4/4/19 by icpadmin. for SingleServer
##
#####################################################################

## REFERENCE {"ibm_network":{"type": "ibm_reference_network"}}

terraform {
  required_version = "> 0.8.0"
}

provider "ibm" {
  softlayer_username = "${var.ibm_sl_username}"
  softlayer_api_key  = "${var.ibm_sl_api_key}"
  version = "~> 0.7"
}


resource "ibm_compute_vm_instance" "single_vm" {
  cores       = 8
  memory      = 16384
  domain      = "${var.single_vm_domain}"
  hostname    = "${var.single_vm_hostname}"
  datacenter  = "${var.single_vm_datacenter}"
  ssh_key_ids = ["${ibm_compute_ssh_key.auth.id}"]
  os_reference_code = "${var.single_vm_os_reference_code}"
  public_vlan_id       = "${var.ibm_network_public_vlan_id}"
  private_vlan_id       = "${var.ibm_network_private_vlan_id}"
  hourly_billing = true
  local_disk = false
  disks = [100,350]
  private_security_group_ids = ["${var.ICP_private_private_id}"]
  public_security_group_ids = ["${var.ICP_public_public_id}"]
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
}

resource "ibm_compute_ssh_key" "auth" {
  label = "${var.ibm_ssh_key_name}"
  public_key = "${tls_private_key.ssh.public_key_openssh}"
}