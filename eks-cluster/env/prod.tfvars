aws_region = "us-east-1"
aws_environment = "prod"

business_devision = "retail"

cluster_name = "eks-cluster"
cluster_version = "1.33"
cluster_service_ipv4_cidr = "172.16.0.0/16"

cluster_endpoint_private_access = false
cluster_endpoint_public_access = true
cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

node_instance_type = ["m7i-flex.large"]
node_capacity_type = "ON_DEMAND"
node_disk_size = 50
