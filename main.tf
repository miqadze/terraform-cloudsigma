terraform {
  required_providers {
    cloudsigma = {
      source  = "cloudsigma/cloudsigma"
      version = "~> 1.11.0"
    }
  }
  backend "local" {
    path = "terraform.tfstate"
  }
}

module "cloudsigma_resources" {
  source = "./auth"

  cloudsigma_username = var.cloudsigma_username
  cloudsigma_password = var.cloudsigma_password
}


module "server" {
  source              = "./modules/server"
  vnc_password        = var.vnc_password
  cloudsigma_username = var.cloudsigma_username
  cloudsigma_password = var.cloudsigma_password
}

module "kubernetes" {
  source              = "./modules/kubernetes"
  cloudsigma_username = var.cloudsigma_username
  cloudsigma_password = var.cloudsigma_password
  vnc_password        = var.vnc_password

}

module "nginx_ingress" {
  source              = "./modules/nginx_ingress"
  cloudsigma_username = var.cloudsigma_username
  cloudsigma_password = var.cloudsigma_password
  vnc_password        = var.vnc_password

}

module "argocd" {
  source              = "./modules/argocd"
  cloudsigma_username = var.cloudsigma_username
  cloudsigma_password = var.cloudsigma_password
  vnc_password        = var.vnc_password

}

variable "vnc_password" {
  description = "VNC password for remote access to the server"
  type        = string
}
