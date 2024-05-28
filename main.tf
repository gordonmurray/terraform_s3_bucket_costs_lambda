terraform {

  required_version = "1.8.3"

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "5.50.0"
    }

  }

}

provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "gordonmurray"
  region                   = "us-east-1"
}
