resource "helm_release" "load_balancer_controller" {
  depends_on = [aws_iam_role.lbc_iam_role,
    aws_eks_node_group.main,
    aws_eks_pod_identity_association.pia-lbc,
    aws_eks_addon.podidentityagent]


  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.4.7"
  namespace  = "kube-system"
  wait       = true
  timeout    = 600
  cleanup_on_fail = true


  set = [
    {
      name  = "serviceAccount.create"
      value = "true"
    },
    {
      name  = "serviceAccount.name"
      value = "aws-load-balancer-controller"
    },
    {
      name  = "clusterName"
      value = "${aws_eks_cluster.main.id}"
    },
    {
      name = "VPCId"
      value = "${data.terraform_remote_state.vpc.outputs.vpc_id}"
    },
    {
      name = "region"
      value = "${var.aws_region}"
    }
    ]
}

# Output:
output "lbc_helm_release_metadata" {
  value       = helm_release.load_balancer_controller.metadata
  description = "The status of the AWS Load Balancer Controller Helm release"
}