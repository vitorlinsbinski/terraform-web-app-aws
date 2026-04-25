terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.42.0"
    }
  }
}


provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      comments  = "this resource is managed by terraform"
      terraform = "true"
      projet    = var.project
    }
  }
}