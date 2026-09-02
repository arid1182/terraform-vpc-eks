data "terraform_remote_state" "vpc" {
    backend = "s3"
    config = {
        bucket = "tfstate-dev-us-east-1-l4i9z9kv"
        key = "tfstate/dev/terraform.tfstate"
        region = var.aws_region
    }
}

output "vpc_id" {
    value = data.terraform_remote_state.vpc.outputs.vpc_id
}

output "private_subnet_ids" {
    value = data.terraform_remote_state.vpc.outputs.private_subnet_ids
}

output "public_subnet_ids" {
    value = data.terraform_remote_state.vpc.outputs.public_subnets_ids
}