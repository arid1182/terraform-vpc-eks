# Helm Release Definition for ASCP (AWS Secrets and Configuration Provider)
resource "helm_release" "aws_secrets_provider" {
  depends_on = [
    aws_iam_role.secretstorecsi_iam_role,
    aws_eks_node_group.main,
    aws_eks_pod_identity_association.pia-secretstorecsi,
    aws_eks_addon.podidentityagent
    ]

  name             = "secrets-provider-aws"
  repository       = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
  chart            = "secrets-store-csi-driver-provider-aws"
  namespace        = "kube-system"
  wait             = true
  timeout          = 600
  cleanup_on_fail  = true


# Avoid conflict of CSI driver (already installed separately)
  set = [
    {
      name  = "secrets-store-csi-driver.install"
      value = "false"
    }
  ]

}

# Output:
output "aws_secrets_provider_helm_release_metadata" {
  value       = helm_release.aws_secrets_provider.metadata
  description = "The status of the AWS Secrets and Configuration Provider Helm release"
}
