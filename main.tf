terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.5"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.proxmox_host
  pm_api_token_id     = var.proxmox_token_id
  pm_api_token_secret = var.proxmox_token_secret
  pm_tls_insecure     = true
}

resource "proxmox_vm_qemu" "terra_test" {
  count = 1
  name  = "terra-vm-${count.index + 1}"

  ssh_user    = "serveradmin"
  target_node = var.proxmox_node
  clone       = var.template_name
  numa        = true

  agent    = 1
  os_type  = "cloud-init"
  cpu      = "host"
  cores    = 2
  sockets  = 1
  memory   = 4096
  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"


  disk {
    slot     = 0
    size     = "16G"
    type     = "scsi"
    storage  = var.fast_vm_storage
    iothread = 1
  }

  network {
    model    = "virtio"
    bridge   = "vmbr1"
    tag      = 1337
    firewall = false
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  vmid      = "6${count.index + 61}"
  ipconfig0 = "ip=10.13.37.${count.index + 61}/24,gw=10.13.37.1"

  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}
