resource "aws_key_pair" "koria_aws_key" {
  key_name   = "koria_aws_key"
  public_key = file(var.PATH_TO_public_KEY)
}

resource "aws_instance" "koria-userdata-instance" {
  ami           = "ami-052f10f1c45aa2155"
  instance_type = "t2.micro"
  //Execute use_data using init_cloud
  user_data = data.template_cloudinit_config.install_apache_config.rendered

  tags = {
    Name = "koria-userdata-instance"
  }
} 

output "public_ip" {
  value = aws_instance.koria-userdata-instance.public_ip
}