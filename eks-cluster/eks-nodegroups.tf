resource "aws_eks_node_group" "eks_nodegroups" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${local.name}-eks-nodegroup"
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  instance_types = var.node_instance_type
  ami_type = "AL2023_x86_64_STANDARD"
  capacity_type = var.node_capacity_type
  disk_size = var.node_disk_size
  force_update_version = true
  labels = {
    "env" = var.aws_environment,
    "team" = var.business_devision
  }


  scaling_config {
    desired_size = 3
    max_size     = 4
    min_size     = 3
  }

  update_config {
    max_unavailable_percentage = 33
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_nodegroup_policy,
    aws_iam_role_policy_attachment.eks_nodegroup_ecr_pull_policy,
    aws_iam_role_policy_attachment.eks_nodegroup_cni_policy
  ]
}
