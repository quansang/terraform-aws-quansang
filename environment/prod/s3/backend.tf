terraform {
  backend "s3" {
    bucket  = "bkqs-iac-state-prod"
    key     = "s3/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "bkqs-prod"
  }
}
