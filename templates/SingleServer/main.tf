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


resource "ibm_compute_vm_instance" "cam-mcm" {
  hostname             = "cam-mcm"
  domain               = "ztechsl.io"
  os_reference_code    = "UBUNTU_16_64"
  datacenter           = "dal13"
  network_speed        = 100
  hourly_billing       = true
  private_network_only = false
  cores                = 8
  memory               = 16384
  disks                = [100,350]
  local_disk           = false
  private_security_group_ids = [1117823]
  public_security_group_ids = [1117813]
  ssh_key_ids          = [1134553,1345699]
}


resource "tls_private_key" "ssh" {
  algorithm = "RSA"
}

resource "ibm_compute_ssh_key" "auth" {
  label = "${var.ibm_ssh_key_name}"
  public_key = "${tls_private_key.ssh.public_key_openssh}"
}