module "server" {
  source              = "../../modules/server"
  cloudsigma_username = var.cloudsigma_username
  cloudsigma_password = var.cloudsigma_password
  vnc_password        = var.vnc_password
}

resource "null_resource" "argocd_setup" {
  depends_on = [module.server]

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      host = module.server.server_ip
      user = "root"
    }

    inline = [
      "kubectl create namespace argocd",
      "kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"
    ]
  }
}
