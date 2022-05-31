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
    # You would have to create the bucket beforehand, where "<your bucket name>=mybucket-tf-state" for example
    bucket         = "<your bucket name>-tf-state"
    # Make sure the key path is unique, where "tf-<your backend name>-backend/terraform.tfstate = tf-mybackendname-backend/terraform.tfstate" for example
    key            = "tf-<your backend name>-backend/terraform.tfstate"
    # Running this the first time, it will create the DynamoDB table through the terraform run
    # Make sure the DynamoDB table name is unique, where "<your table name>=mytable.tf-state" for example
    dynamodb_table = "<your table name>-tf-state"
    profile        = "default"
    region         = "us-east-1"
  }
}

provider "aws" {
}
