resource "aws_key_pair" "koria-vpc-key" {
  key_name   = "koria-vpc-key"
  public_key = file(var.PATH_TO_public_KEY)
}

resource "aws_instance" "koria-ec2ebs-instance" {
  ami           = "ami-052f10f1c45aa2155"
  instance_type = "t2.micro"

  tags = {
    Name = "koria-ec2-instance"
  }
} 

#create ebs volume
resource "aws_ebs_volume" "koria-ebs-volume" {
  availability_zone = "eu-west-3c"
  size              = 20
  type  =  "gp2"
  tags = {
    Name = "koria-ebs-volume"
  }
}

#create volume attachment
resource "aws_volume_attachment" "koria-ebs-att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.koria-ebs-volume.id
  instance_id = aws_instance.koria-ec2ebs-instance.id
}