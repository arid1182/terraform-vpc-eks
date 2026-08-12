# Install Secrets Store CSI Driver (Kubernetes SIGs)

# Helm Release Definition
resource "helm_release" "secrets_storecsi_driver" {
  depends_on = [
    aws_iam_role.secretstorecsi_iam_role,
    aws_eks_node_group.main,
    aws_eks_pod_identity_association.pia-secretstorecsi,
    aws_eks_addon.podidentityagent
    ]

  name             = "csi-secrets-store"
  repository       = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart            = "secrets-store-csi-driver"
  namespace        = "kube-system"
# create_namespace = true
# atomic           = true

# Wait until all pods are ready
  wait             = true
  timeout          = 600
  cleanup_on_fail  = true

# Note: tokenRequests is required for EKS Pod Identity authentication when
# the CSI driver is installed separately (not bundled via the AWS provider chart).
# Audience "pods.eks.amazonaws.com" is for EKS Pod Identity. We do not configure
# the IRSA audience (sts.amazonaws.com) because this course uses Pod Identity only.

# Inject specific string, integer, or sensitive values directly
  set = [
    {
      name    = "syncSecret.enabled"
      value   = "true"
    },
    {
      name  = "tokenRequests[0].audience"
      value = "pods.eks.amazonaws.com"
    }
]
}

# Output:
output "secrets_storecsi_driver_helm_release_metadata" {
  value       = helm_release.secrets_storecsi_driver.metadata
  description = "The status of the Secrets Store CSI Driver Helm release"
}