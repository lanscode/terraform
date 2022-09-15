resource "aws_key_pair" "koria-vpc-key" {
  key_name   = "koria-vpc-key"
  public_key = file(var.PATH_TO_public_KEY)
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "koria-ec2-instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  #security group
vpc_security_group_ids = [aws_security_group.koria-vpc-secu-group.id]
#the subnet of my instance
subnet_id = aws_subnet.koria-vpc-subnet-1.id

  tags = {
    Name = "koria-ec2-instance"
  }
} 