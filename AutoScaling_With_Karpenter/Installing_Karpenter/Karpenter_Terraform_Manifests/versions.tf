terraform{
    required_version = ">= 1.57"

    required_providers {

        aws = {
        source = "hashicorp/aws"
        version = ">= 6.20"
        }

        helm = {
            source = "hashicorp/helm"
            version = "~> 3.0"
        }

        kubernetes = {
            source = "hashicorp/kubernetes"
            version = ">= 2.28"
        }
    }

    backend "s3" {
        bucket = "tfstate-dev-us-east-1-l4i9z9kv"
        key = "karpenter/dev/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        use_lockfile = true
    }
}

provider "aws" {
  region = var.aws_region
}