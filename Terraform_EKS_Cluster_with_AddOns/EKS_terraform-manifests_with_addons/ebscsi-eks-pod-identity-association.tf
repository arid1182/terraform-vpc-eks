# Resource: EKS Pod Identity Association for EBS CSI Driver
resource "aws_eks_pod_identity_association" "pia-ebscsi" {
  cluster_name    = aws_eks_cluster.main.name
  namespace       = "kube-system"
  service_account = "ebs-csi-controller-sa"
  role_arn        = aws_iam_role.ebs_csi_iam_role.arn
}

# Output: EBS CSI Pod Identity Association ARN
output "ebs_csi_pod_identity_association_arn" {
  value       = aws_eks_pod_identity_association.pia-ebscsi.arn
  description = "The ARN of the EBS CSI Pod Identity Association"
}