# Datasource: Get the default EBS CSI addon version compatible with EKS version
data "aws_eks_addon_version" "ebs_csi_default" {
  addon_name = "aws-ebs-csi-driver"
  kubernetes_version = aws_eks_cluster.main.version
}

# Datasource: Get the latest available EBS CSI addon version
data "aws_eks_addon_version" "ebs_csi_latest" {
  kubernetes_version = aws_eks_cluster.main.version
  addon_name   = "aws-ebs-csi-driver"
  most_recent  = true
}

# Resource: Install EBS CSI Driver addon
resource "aws_eks_addon" "ebs_csi" {
   depends_on = [ aws_iam_role.ebs_csi_iam_role,
   aws_eks_node_group.main,
   aws_eks_pod_identity_association.pia-ebscsi,
   aws_eks_addon.podidentityagent
   ]


   cluster_name                = aws_eks_cluster.main.name
   addon_name                  = "aws-ebs-csi-driver"
   addon_version               = data.aws_eks_addon_version.ebs_csi_latest.addon_version
   service_account_role_arn    = aws_iam_role.ebs_csi_iam_role
   resolve_conflicts_on_update = "OVERWRITE"
   resolve_conflicts_on_create = "OVERWRITE"

   tags = {
     Name        = "${local.name}-ebs_csi_addon"
     Environment = var.aws_environment
     Component   = "EBS CSI Driver"
   }
}

# Output:

output "ebs_csi_driver_addon_default_version" {
  value       = aws_eks_addon_version.ebs_csi_default.addon_version
  description = "The default version of the EBS CSI Driver addon compatible with the EKS version"
}

output "ebs_csi_driver_addon_latest_version" {
  value       = aws_eks_addon_version.ebs_csi_latest.addon_version
  description = "The latest available version of the EBS CSI Driver addon"
}

output "ebs_csi_driver_addon_default_version" {
  value       = aws_eks_addon_version.ebs_csi_default.addon_version
  description = "The default version of the EBS CSI Driver addon compatible with the EKS version"
}

output "ebs_csi_addon_arn" {
  value       = aws_eks_addon.ebs_csi.arn
  description = "The ARN of the EBS CSI Driver addon"
}

output "ebs_csi_addon_id" {
  value       = aws_eks_addon.ebs_csi.id
  description = "The ID of the EBS CSI Driver addon"
}