#VPC

resource "aws_vpc" "KuraVpc" {
   cidr_block           = "172.19.0.0/16"
  enable_dns_hostnames = "true"
}

#SUBNETS

resource "aws_subnet" "pubsubnet1" {
  cidr_block              = "172.19.0.0/18"
  vpc_id                  = aws_vpc.KuraVpc.id
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[0]
}

resource "aws_subnet" "pubsubnet2" {
  cidr_block              = "172.19.0.0/19"
  vpc_id                  = aws_vpc.KuraVpc.id
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[0]
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "KuraGateway" {
  vpc_id = aws_vpc.KuraVpc.id
}

# ROUTE TABLE
resource "aws_route_table" "route_table1" {
  vpc_id = aws_vpc.KuraVpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.KuraGateway.id
  }
}

resource "aws_route_table_association" "route-subnet1" {
  subnet_id      = aws_subnet.pubsubnet1.id
  route_table_id = aws_route_table.route_table1.id
}

# Data
data "aws_availability_zones" "available" {
  state = "available"
}
