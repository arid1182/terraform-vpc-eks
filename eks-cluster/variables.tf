variable "aws_region" {
    description = "this is aws EKS cluster region"
    default = "us-east-1"
    type = string
}

variable "aws_environment" {
    description = "this is envrironment for aws EKS Cluster"
    type = string
    default = "dev"
}

variable "business_devision" {
    description = "this is the cidr block for vpc"
    type = string
    default = "retail"
}

variable "cluster_name" {
    description = "this is the EKS cluster name"
    type = string
    default = "eks-cluster"
}

variable "cluster_version" {
    description = "this is the EKS cluster version (e.g 1.28, 1.29 )"
    type = string
    default = null
}

variable "cluster_service_ipv4_cidr" {
    description = "Service CIDR range for kubernetese services, leave null to use AWS default "
    type = string
    default = null
}

variable "cluster_endpoint_private_access" {
    description = "weather to allow private access to EKS controle plane endpoint"
    type = bool
    default = false
}

variable "cluster_endpoint_public_access" {
    description = "weather to allow public access to EKS controle plane endpoint"
    type = bool
    default = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks allowed to access public EKS endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "node_instance_type" {
    description = "List the EC2 instance type for the node group"
    type = list(string)
    default = ["t3.small"]
}

variable "node_capacity_type" {
    description = "Instance Capacity Type: ON_DEMAND, ON_SPOT"
    type = string
    default = "ON_DEMAND"
}

variable "node_disk_size" {
    description = "Node Group Disk size in GIB"
    type = number
    default = 20
}


variable "tags" {
    description = "the tags policy for aws vpc"
    type = map(string)
    default = {
      terraform = true
      Project = "Retail Shop"
      Owner = "Mubasher Hassan"
    }
  
}