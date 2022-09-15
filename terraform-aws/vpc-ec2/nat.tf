resource "aws_eip" "koria-elastic-ip" {
  vpc      = true
}

resource "aws_nat_gateway" "koria-nat-getway" {
  allocation_id = aws_eip.koria-elastic-ip.id
  subnet_id     = aws_subnet.koria-vpc-private-subnet-1.id

  tags = {
    Name = "koria-nat-getway"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.koria-gw]
}

#private routing table to bloc the access to my vpc from the internet
resource "aws_route_table" "koria-private_routing-table" {
  vpc_id = aws_vpc.koria-vpc.id

  route {
    cidr_block = "0.0.0.0/0" #forbid the access to my vpc from the internet although the opposite is allowed
    nat_gateway_id = aws_nat_gateway.koria-nat-getway.id
  }

  tags = {
    Name = "koria-private_routing-table"
  }

}

#route association for first subnet
resource "aws_route_table_association" "koria-private-rt-assoc-1" {
  subnet_id      = aws_subnet.koria-vpc-private-subnet-1.id
  route_table_id = aws_route_table.koria-private_routing-table.id
}