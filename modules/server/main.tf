data "cloudsigma_library_drive" "debian" {
  filter {
    name   = "name"
    values = ["Debian 10.13 Server"]
  }
}
resource "cloudsigma_drive" "debian" {
  clone_drive_id = data.cloudsigma_library_drive.debian.id

  media = "disk"
  name  = "drive"
  size  = 50 * 1024 * 1024 * 1024 # 50gb
}

resource "cloudsigma_server" "main" {
  name         = "k8s-server"
  cpu          = 2000               # 2 GHz
  memory       = 4096 * 1024 * 1024 # 4 GB RAM
  vnc_password = var.vnc_password
  drive {
    uuid = cloudsigma_drive.debian.uuid
  }
}
provider "cloudsigma" {
  username = var.cloudsigma_username
  password = var.cloudsigma_password
  location = "tbc"
  base_url = "cloudsigma.com/api/2.0/"
}

output "server_ip" {
  value = cloudsigma_server.main.ipv4_address
}


