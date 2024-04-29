resource "cloudsigma_server" "main" {
  name         = "k8s-server"
  cpu          = 2000 # 2 GHz
  memory       = 4096 # 4 GB RAM
  vnc_password = var.vnc_password

  #  drive {
  #    uuid = cloudsigma_drive.s3_caching_drive.id
  #  }
}
provider "cloudsigma" {
  username = var.cloudsigma_username
  password = var.cloudsigma_password
}

output "server_ip" {
  value = cloudsigma_server.main.ipv4_address
}


