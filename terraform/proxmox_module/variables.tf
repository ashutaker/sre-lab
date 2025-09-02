variable "vm_name" {
  description = "Name of the VM, also serves as hostname"
  type        = string
}

variable "target_pm_node" {
  description = "Node on which the VM will be started"
  type        = string
  default     = "pxmx02"
}

variable "vm_template_name" {
  description = "Name of the template used to create the VM"
  type        = string
}

variable "pm_host" {
  description = "Proxmox cluster/node host. IP or FQDN"
  type        = string
}

variable "pm_api_token_id" {
  description = "Proxmox Token ID"
  type        = string
  sensitive = true
}

variable "pm_api_token_secret" {
  description = "Proxmox Token ID"
  type        = string
  sensitive = true
}

variable "ci_ssh_key" {
  description = "CloudInit SSH keys for the host"
  type        = string
  sensitive = true
}

variable "vm_memory" {
  type        = number
  description = "Memory allocation for the vm"
  # default = 1024
}

variable "vm_cpu" {
  type = object({
    cores   = optional(number,1)
    limit   = optional(number,0)
    numa    = optional(bool,false)
    sockets = optional(number,1)
    type    = optional(string,"host")
    units   = optional(number,0)
    vcores  = optional(number,0)
  })
}
