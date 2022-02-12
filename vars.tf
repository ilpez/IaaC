variable "ssh_key" {
  type      = string
  sensitive = true
}

variable "proxmox_token_id" {
  type      = string
  sensitive = true
}

variable "proxmox_token_secret" {
  type      = string
  sensitive = true
}

variable "proxmox_host" {
  type      = string
  sensitive = true
}

variable "proxmox_node" {
  default = "pve-01"
}

variable "template_name" {
  default = "ubuntu-2004-init"
}

variable "fast_vm_storage" {
  default = "local-zfs-vm"
}
