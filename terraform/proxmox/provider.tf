terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}

provider "proxmox" {
  pm_api_url = "http://10.42.0.13:8006/api2/json"
  pm_api_token_id = "user"
  pm_api_token_secret = "secret"
  pm_tls_insecure = true
}