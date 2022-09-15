resource "aws_key_pair" "koria_aws_key" {
  key_name   = "koria_aws_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "koria-userdata-instance" {
  ami           = "ami-052f10f1c45aa2155"
  instance_type = "t2.micro"
#IAM instance profile
iam_instance_profile = aws_iam_instance_profile.koria_s3_role_instance.name
  tags = {
    Name = "koria-userdata-instance"
  }
  
} 

output "public_ip" {
  value = aws_instance.koria-userdata-instance.public_ip
}