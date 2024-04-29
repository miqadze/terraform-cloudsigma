module "server" {
  source              = "../../modules/server"
  cloudsigma_username = var.cloudsigma_username
  cloudsigma_password = var.cloudsigma_password
  vnc_password        = var.vnc_password

}

resource "null_resource" "kubernetes_setup" {
  depends_on = [module.server]

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      host = module.server.server_ip
      user = "root"
    }

    inline = [
      "apt-get update && apt-get install -y apt-transport-https curl",
      "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -",
      "echo 'deb https://apt.kubernetes.io/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list",
      "apt-get update",
      "apt-get install -y kubelet kubeadm kubectl",
      "kubeadm init --pod-network-cidr=10.244.0.0/16"
    ]
  }
}
