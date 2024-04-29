terraform {
  required_providers {
    cloudsigma = {
      source = "cloudsigma/cloudsigma"
    }
  }
}

provider "cloudsigma" {
  username = var.cloudsigma_username
  password = var.cloudsigma_password
}
