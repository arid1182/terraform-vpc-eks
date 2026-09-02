
data "terraform_remote_state" "eks" {
    backend = "s3"
    config = {
        bucket = "tfstate-dev-us-east-1-l4i9z9kv"
        key    = "vpc/dev/terraform.tfstate"
        region = var.aws_region
    }
}

output "eks_cluster_name" {
    value = data.terraform_remote_state.eks.outputs.eks_cluster_name
}

output "eks_cluster_id" {
    value = data.terraform_remote_state.eks.outputs.eks_cluster_id
}