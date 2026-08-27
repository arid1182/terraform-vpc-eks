terraform {
  required_version = ">=1.9.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = ">=6.47.0"
    }
    random = {
        source = "hashicorp/random"
        version = ">=3.0"
    }
  }
  
  backend "s3" {
    bucket = "tfstate-dev-us-east-1-l4i9z9kv"
    key = "vpc/dev/terraform.tfstate"
    encrypt = true
    use_lockfile = true
    region = "us-east-1"
  }
}

provider "aws" {
    region = "us-east-1"
}