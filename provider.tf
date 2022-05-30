terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.70.0"
    }
  }

  # NOTE:
  #     read the README.md first
  backend "s3" {
    # Make sure the exact bucket name exists before running this
    bucket         = "cequence-tf-state"
    key            = "tf-cequence-backend/terraform.tfstate"
    dynamodb_table = "cequence-tf-state"
    profile        = "default"
    region         = "us-east-1"
  }
}

provider "aws" {
}