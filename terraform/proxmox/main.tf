resource "proxmox_vm_qemu" "test" {
  name = "tf-test"

  target_node = "pxmx02"

  #clone from
  clone_id   = 1100
  full_clone = true
  

  #cloud-init options
  memory  = 1024
  os_type = "cloud_init"
  cores   = 2
  sockets = 1
#   agent = 1

  # Disk parameters
  scsihw = "virtio-scsi-single"

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local"
        #   storage = "local-lvm" # deleted the lvm in proxmox and using local
        }
      }
    }

    scsi {
      scsi0 {
        disk {
          storage = "local"
        #   storage = "local-lvm" # deleted the local-lvm in proxmox and using local
          size    = "20G"
          # discard=true
          cache     = "writeback"
          replicate = true
        }
      }
    }
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
    id     = 0
  }

  boot      = "order=scsi0"
  ipconfig0 = "ip=dhcp"

  serial {
    id   = 0
    type = "socket"
  }

#   ciuser     = "xxxx"
#   cipassword = "xxxxxxxx"
#   sshkeys = <<EOF
#     ssh-rsa xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx user@pc
#     EOF


  lifecycle {
    ignore_changes = [ network ]
  }


}


