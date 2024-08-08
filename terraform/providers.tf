provider "aws" {
  region     = "us-east-2"
  access_key  = var.aws_access_key
  secret_key  = var.aws_secret_key
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"  # Or the latest version
    }
  }
}
