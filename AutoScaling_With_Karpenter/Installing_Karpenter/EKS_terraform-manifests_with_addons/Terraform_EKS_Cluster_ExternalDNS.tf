# ExternalDNS IAM Role (for Pod Identity)
resource "aws_iam_role" "externaldns_role" {
  name = "${local.name}-externaldns-iam-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Attach AWS Managed Route53 Full Access
resource "aws_iam_role_policy_attachment" "externaldns_route53_full_access" {
  role       = aws_iam_role.externaldns_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
}

# Output
output "externaldns_iam_role_arn" {
  value = aws_iam_role.externaldns_role.arn
}

# ExternalDNS Pod Identity Association
resource "aws_eks_pod_identity_association" "pia-externaldns" {
  cluster_name = aws_eks_cluster.main.name
  namespace    = "external-dns"
  service_account = "external-dns"
  role_arn     = aws_iam_role.externaldns_role.arn
}

# Output
output "externaldns_pod_identity_association_id" {
  value = aws_eks_pod_identity_association.pia-externaldns.id
}

##############################################
# Discover latest ExternalDNS addon version
##############################################
data "aws_eks_addon_version" "externaldns" {
  addon_name = "external-dns"
  kubernetes_version = aws_eks_cluster.main.version
  most_recent = true
}

# Install ExternalDNS Add-on
resource "aws_eks_addon" "externaldns" {
    depends_on = [aws_eks_pod_identity_association.pia-externaldns,
                  aws_iam_role_policy_attachment.externaldns_route53_full_access, aws_eks_node_group.eks_nodegroups
                  ]
                    
  cluster_name = aws_eks_cluster.main.name
  addon_name   = "external-dns"
  addon_version = data.aws_eks_addon_version.externaldns.version
  service_account_role_arn = aws_iam_role.externaldns_role.arn
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  tags = {
    component = "external-dns"
    Project   = local.name
    ManagedBy = "Terraform"
  }
 
}

# Outputs
output "externaldns_addon_version" {
  value = aws_eks_addon.externaldns.addon_version
}

output "externaldns_addon_id" {
  value = aws_eks_addon.externaldns.id
}

output "externaldns_addon_arn" {
  value = aws_eks_addon.externaldns.arn
}