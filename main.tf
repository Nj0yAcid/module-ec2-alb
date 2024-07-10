# create a vpc
resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    "Name" = var.vpc_name
  }
}

# create an internet gateway
resource "aws_internet_gateway" "this-igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    "Name" = "Application-lb-gateway"
  }
}

# create a private subnet 

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.private_subnet_cidr_block
  availability_zone = var.subnet_AZ_1
  map_public_ip_on_launch = false
  tags = {
    Name = "private"
  }
}

# create a public subnet 

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_cidr_block_1
  availability_zone = var.subnet_AZ_1
  map_public_ip_on_launch = false
  tags = {
    Name = "public-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_cidr_block_2
  availability_zone = var.subnet_AZ_2
  map_public_ip_on_launch = false
  tags = {
    Name = "public-2"
  }
}

# create a eip and nat 

resource "aws_eip" "my_eip" {

}

resource "aws_nat_gateway" "my_nat" {
  allocation_id = aws_eip.my_eip.id
  subnet_id = aws_subnet.public_subnet_1.id
}

# create a route table for the public subnet 1
resource "aws_route_table" "rtpublic" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = var.rtpublic_cidr_block
        gateway_id = aws_internet_gateway.this-igw.id
        }
}

# create a route table for the public subnet 
resource "aws_route_table" "rtprivate" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = var.rtprivate_cidr_block
        gateway_id = aws_nat_gateway.my_nat.id
        }
}

# create route table association 

resource "aws_route_table_association" "rtpublic-association1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.rtpublic.id
}

# create route table association 

resource "aws_route_table_association" "rtpublic-association2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.rtpublic.id
}

resource "aws_route_table_association" "rtprivate-association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.rtprivate.id
}