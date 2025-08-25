terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc03"
    }
  }
}

provider "proxmox" {
  pm_api_url          = "https://xxx.xxx.xxx.xxx:8006/api2/json"
  pm_api_token_id     = "XXXX"
  pm_api_token_secret = "XXXX"
  pm_tls_insecure     = true
}


resource "proxmox_vm_qemu" "cloudinit-test" {
  name = "terraform-test"

  target_node = "pxmx02"

  clone = "ubuntu-2404-base-template"

  # Activate QEMU agent for this VM
  agent = 1
  memory  = 2048
  scsihw  = "virtio-scsi-single"

  # CloudInit configurations
  ciuser = "ashu"
  cipassword = "ashu"
  sshkeys = "XXXX"
  ipconfig0="ip=dhcp"
  
  cpu {
    cores = 1
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
          size    = 30
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



