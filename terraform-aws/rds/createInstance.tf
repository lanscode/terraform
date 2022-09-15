resource "aws_key_pair" "koria_aws_key" {
  key_name   = "koria_aws_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "koria-userdata-instance" {
  ami           = "ami-052f10f1c45aa2155"
  instance_type = "t2.micro"
//define the security group
vpc_security_group_ids = [aws_security_group.vpc-secu-group.id]
//Define the public subnet as well
subnet_id = aws_subnet.koria-vpc-subnet-1.id

  tags = {
    Name = "koria-userdata-instance"
  }
  
} 

output "public_ip" {
  value = aws_instance.koria-userdata-instance.public_ip
}