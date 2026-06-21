data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "tfstate-dev-us-east-1-l4i9z9kv"
    region = var.aws_region
    key = "tfstate/dev/terraform.tfstate"
  }
}


output "vpc_id" {
    value = data.terraform_remote_state.vpc.outputs.vpc_id
    description = "VPC Id for EKS Cluster"
}

output "private_subnet_ids" {
  value       = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  description = "Private subnets for EKS worker nodes"
}

output "public_subnet_ids" {
  value       = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  description = "Public subnets for ALB, NLB, etc."
}

output "public_subnet_map" {
  value       = data.terraform_remote_state.vpc.outputs.public_subnet_map
  description = "Public subnets for ALB, NLB, etc."
}

