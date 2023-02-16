/*
# ------------------------------------------------------------------------------
# SETUP TERRAFORM STATE BACKEND
# ------------------------------------------------------------------------------
terraform {
  backend "s3" {
    bucket         = ""
    key            = "terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = ""
    encrypt        = "true"
  }
}
*/

# ------------------------------------------------------------------------------
# Terraform Version
# ------------------------------------------------------------------------------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

# ------------------------------------------------------------------------------
# Setup Provider
# ------------------------------------------------------------------------------
provider "aws" {
  region = var.aws_region
}

