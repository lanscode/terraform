resource "aws_key_pair" "koria-vpc-key" {
  key_name   = "koria-vpc-key"
  public_key = file(var.PATH_TO_public_KEY)
}

resource "aws_instance" "koria-userdata-instance" {
  ami           = "ami-052f10f1c45aa2155"
  instance_type = "t2.micro"
  //Execute use_data script
  user_data = file("installapache.sh")

  tags = {
    Name = "koria-userdata-instance"
  }
} 

output "public_ip" {
  value = aws_instance.koria-userdata-instance.public_ip
}