locals {
  name = var.business_devision
  eks_cluster_name = "${var.business_devision}-${var.aws_environment}-${var.cluster_name}" # retial-dev-eks-cluster
  Owner = var.aws_environment
}
