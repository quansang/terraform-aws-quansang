###################
# General Initialization
###################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.33"
    }
    sops = {
      source  = "carlpett/sops"
      version = "~> 0.6"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = var.region
  profile = "${var.project}-${var.env}"
}
data "aws_caller_identity" "current" {}

# # Configure the SOPS Provider
# provider "sops" {}
# data "sops_file" "secret_variables" {
#   source_file = "../../../sops/secrets.${var.env}.yaml"
# }
