# Resource-1: VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  lifecycle {
    prevent_destroy = false
  }
  tags = merge(var.tags, { Environment = "${var.aws_environment}-vpc"})
}

# Resource-2: Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = merge(var.tags, { Environment = "${var.aws_environment}-igw"})
}

# Resource-3: Public Subnets
resource "aws_subnet" "public" {
  for_each = { for idx, az in local.azs : az => local.public_subnet[idx] }
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value
  availability_zone = each.key
  map_public_ip_on_launch = true
  tags = merge(var.tags, { Environment = "${var.aws_environment}-public_subnet"})
}

# Resource-4: Private Subnets
resource "aws_subnet" "private" {
  for_each = { for idx, az in local.azs: az => local.private_subnet[idx] }
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value
  availability_zone = each.key
  tags = merge(var.tags, { Environment = "${var.aws_environment}-private_subnet"})
}

# Resource-5: Elastic IP for NAT Gateway
resource "aws_eip" "eip" {
  depends_on = [aws_internet_gateway.igw]
  tags = merge(var.tags, { Environment = "${var.aws_environment}-eip"})
}

# Resource-6: NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = values(aws_subnet.public)[0].id
  tags = merge(var.tags, { Environment = "${var.aws_environment}-nat_gateway"})
  depends_on = [aws_internet_gateway.igw]
}
# Resource-7: Public Route Table
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(var.tags, { Environment = "${var.aws_environment}-public_rt_table"})
}
# Resource-8: Public Route Table Associate to Public Subnet
resource "aws_route_table_association" "public_route_table_association" {
  for_each = aws_subnet.public
  subnet_id = each.value.id
  route_table_id = aws_route_table.public_route.id
}

# Resource-9: Private Route Table
resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = merge(var.tags, { Environment = "${var.aws_environment}-private_rt_table"})
}
# Resource-10: Private Route Table Association to Private Subnet
resource "aws_route_table_association" "privete_route_table_association" {
  for_each = aws_subnet.private
  subnet_id = each.value.id
  route_table_id = aws_route_table.private_route.id
}