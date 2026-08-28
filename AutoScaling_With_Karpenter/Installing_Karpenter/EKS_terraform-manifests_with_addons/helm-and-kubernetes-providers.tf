# Authenticates: It generates a short-lived authentication token using aws_eks_cluster_auth.
data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.main.name
}

# Connects: It points the Helm provider to your specific AWS EKS cluster endpoint.
provider "helm" {
  kubernetes = {
    host                   = aws_eks_cluster.main.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

# Secures: It uses the cluster certificate authority to secure the communication channel.
provider "kubernetes" {
  host                   = aws_eks_cluster.main.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}