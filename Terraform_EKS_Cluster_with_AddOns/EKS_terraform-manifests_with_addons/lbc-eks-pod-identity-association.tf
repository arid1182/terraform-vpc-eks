# EKS Pod Identity Association for LBC
resource "aws_eks_pod_identity_association" "pia-lbc" {
  namespace = "kube-system"
  cluster_name = aws_eks_cluster.main.name
  service_account = "aws-load-balancer-controller"
  role_arn = aws_iam_role.lbc_iam_role.arn
}

# Output: Pod Identity Association ARN
output "lbc_pod_identity_association_arn" {
  value       = aws_eks_pod_identity_association.pia-lbc.arn
  description = "The ARN of the AWS Load Balancer Controller Pod Identity Association"
}