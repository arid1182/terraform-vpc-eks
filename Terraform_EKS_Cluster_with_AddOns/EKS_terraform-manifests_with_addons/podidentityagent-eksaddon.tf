# Datasource: To get default EKS addon version compatible with EKS cluster version
data "aws_eks_addon_version" "default" {
  addon_name         = "eks-pod-identity-agent"
  kubernetes_version = aws_eks_cluster.main.version
}

data "aws_eks_addon_version" "latest" {
  addon_name         = "eks-pod-identity-agent"
  kubernetes_version = aws_eks_cluster.main.version
  most_recent        = true
}

resource "aws_eks_addon" "podidentityagent" {
depends_on = [aws_eks_node_group.eks_nodegroups]
  cluster_name                = aws_eks_cluster.main.name
  addon_name                  = "eks-pod-identity-agent"
  addon_version               = data.aws_eks_addon_version.latest.version
  resolve_conflicts_on_update = "PRESERVE"
  resolve_conflicts_on_create = "PRESERVE"
}

# Outputs
output "pod_identity_agent_eksaddon_default_version" {
  value = data.aws_eks_addon_version.default.version
}

output "pod_identity_agent_eksaddon_lastest_version" {
  value = data.aws_eks_addon_version.latest.version
}
output "pod_identity_agent_eksaddon_arn" {
  value = aws_eks_addon.podidentityagent.arn
}  

output "pod_identity_agent_eksaddon_id" {
  value = aws_eks_addon.podidentityagent.id
}