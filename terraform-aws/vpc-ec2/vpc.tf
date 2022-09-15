#Create vpc
resource "aws_vpc" "koria-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  //enable_classiclink = "false"


  tags = {
    Name = "koria-vpc"
  }
}
#Create 3 public subnets
resource "aws_subnet" "koria-vpc-subnet-1" {
  vpc_id     = aws_vpc.koria-vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "eu-west-3a"

  tags = {
    Name = "koria-vpc-subnet-1"
  }
}
resource "aws_subnet" "koria-vpc-subnet-2" {
  vpc_id     = aws_vpc.koria-vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "eu-west-3b"

  tags = {
    Name = "koria-vpc-subnet-2"
  }
}
resource "aws_subnet" "koria-vpc-subnet-3" {
  vpc_id     = aws_vpc.koria-vpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "eu-west-3c"

  tags = {
    Name = "koria-vpc-subnet-3"
  }
}

#Create 1 private subnets
resource "aws_subnet" "koria-vpc-private-subnet-1" {
  vpc_id     = aws_vpc.koria-vpc.id
  cidr_block = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "eu-west-3a"

  tags = {
    Name = "koria-vpc-private-subnet-1"
  }
}

#create internet getways
resource "aws_internet_gateway" "koria-gw" {
  vpc_id = aws_vpc.koria-vpc.id

  tags = {
    Name = "koria-gw"
  }
}

#Routing table 
resource "aws_route_table" "koria-routing-table" {
  vpc_id = aws_vpc.koria-vpc.id

  route {
    cidr_block = "0.0.0.0/24"
    gateway_id = aws_internet_gateway.koria-gw.id
  }

  tags = {
    Name = "koria-routing-table"
  }
}

#route table require the creation of route_association_table
#route association for first subnet
resource "aws_route_table_association" "koria-rt-association-1" {
  subnet_id      = aws_subnet.koria-vpc-subnet-1.id
  route_table_id = aws_route_table.koria-routing-table.id
}
#route association for first subnet
resource "aws_route_table_association" "koria-rt-association-2" {
  subnet_id      = aws_subnet.koria-vpc-subnet-2.id
  route_table_id = aws_route_table.koria-routing-table.id
}
#route association for first subnet
resource "aws_route_table_association" "koria-rt-association-3" {
  subnet_id      = aws_subnet.koria-vpc-subnet-3.id
  route_table_id = aws_route_table.koria-routing-table.id
}