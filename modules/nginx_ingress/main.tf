module "server" {
  source              = "../../modules/server"
  cloudsigma_username = var.cloudsigma_username
  cloudsigma_password = var.cloudsigma_password
  vnc_password        = var.vnc_password
}

resource "null_resource" "nginx_ingress_setup" {
  depends_on = [module.server]

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      host = module.server.server_ip
      user = "root"
    }

    inline = [
      "kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml"
    ]
  }
}
