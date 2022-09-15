resource "aws_security_group" "koria-vpc-secu-group" {
  name        = "koria-vpc-secu-group"
  description = "allow ssh inbound traffic"
  vpc_id      = aws_vpc.koria-vpc.id

#from internet to my vpc
  ingress {
    description      = "ssh from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] #all ip // [aws_vpc.koria-vpc.cidr_block]
     }
#from the vpc to the internet
  egress {
    from_port        = 0 #all port
    to_port          = 0
    protocol         = "-1"  #all procols
    cidr_blocks      = ["0.0.0.0/0"] #all ip
  }

  tags = {
    Name = "koria-vpc-secu-group"
  }
}