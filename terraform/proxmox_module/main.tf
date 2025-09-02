terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc03"
    }
  }
}

# provider "proxmox" {
#   pm_api_url          = "https://${var.pm_host}:8006/api2/json"
#   pm_api_token_id     = var.pm_api_token_id
#   pm_api_token_secret = var.pm_api_token_secret
#   pm_tls_insecure     = true
# }


resource "proxmox_vm_qemu" "cloudinit-test" {
  name = var.vm_name

  target_node = var.target_pm_node

  clone = var.vm_template_name

  # Activate QEMU agent for this VM
  agent = 1
  memory  = var.vm_memory
  scsihw  = "virtio-scsi-single"

  # CloudInit configurations
  ciuser = "ashu"
  cipassword = "ashu"
  sshkeys = var.ci_ssh_key
  ipconfig0="ip=dhcp"
  
  cpu {
    cores = var.vm_cpu.cores
    sockets =1
  }

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local"
        }
      }
    }
    
    scsi {
      scsi0 {
        # match the size with the template size or larger
        disk {
          size    = 20
          cache   = "writeback"
          storage = "local"
        }
      }
    }
  }

  network{
    id=0
    model = "virtio"
    bridge = "vmbr0"
  }

  boot = "order=scsi0"
  
  serial{
    id=0
    type="socket"
  }

}

output "ip_address" {
  value = proxmox_vm_qemu.cloudinit-test.description
}


