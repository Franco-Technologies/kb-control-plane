terraform {
  backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.21.0"
    }
  }
}

provider "aws" {
  region = var.region
  alias  = "default"
}

provider "aws" {

  region = var.region
  assume_role {
    role_arn     = var.role
    session_name = "CICD-Franco-Tech"
  }
}
