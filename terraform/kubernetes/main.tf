terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc03"
    }
  }
}

provider "proxmox" {
  pm_api_url          = "https://${var.pm_host}:8006/api2/json"
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  pm_tls_insecure     = true
  alias               = "module"
}

variable "pm_host" {
  description = "Proxmox cluster/node host. IP or FQDN"
  type        = string
}

variable "pm_api_token_id" {
  description = "Proxmox Token ID"
  type        = string
}

variable "pm_api_token_secret" {
  description = "Proxmox Token secret"
  type        = string
}

variable "ci_ssh_key" {
  description = "CloudInit SSH keys for the host"
  type        = string
}

variable "vm_cpu" {
  type = object({
    cores = number
    # limit   = number
    # numa    = false
    # sockets = 1
    type = optional(string, "host")
    # units   = 0
    # vcores  = 0
  })
  default = {
    cores = 1
  }
}

locals {
  configs = yamldecode(file("${path.module}/kube-lab.yaml"))
}

module "k8s-control-plane" {
  for_each = local.configs
  source   = "../proxmox_module"
  providers = {
    proxmox = proxmox.module
  }

  # from kube-lab config
  vm_name          = each.value.vm_name
  vm_template_name = each.value.vm_template_name
  vm_cpu           = try(each.value.cpu, var.vm_cpu)
  vm_memory        = each.value.memory
  vm_count         = try(each.value.vm_count, 1)

  # from env variable
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  ci_ssh_key          = var.ci_ssh_key
  pm_host             = var.pm_host


}
