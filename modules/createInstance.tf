resource "aws_key_pair" "ssh_key" {
  key_name   = "ansible_aws_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}
provider "aws"{
    access_key = "${var.AWS_ACCESS_KEY}"
    secret_key = "${var.AWS_SECRET_KEY}"
    region = "${var.AWS_REGION}"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  cidr = var.vpc_cidr_block

  azs             = [var.availability_zone]
  public_subnets  = [var.subnet_cidr_block]                              
  tags = {
    Name = "${var.env-prefix}-vpc"
  }
}

module "dev-sg" {
  source = "terraform-aws-modules/security-group/aws"
  name        = "${var.env-prefix}-sg"
  description = "Open webserver and ssh"
  vpc_id      = module.vpc.vpc_id

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "outgoing"
      name        = "internet access"
      cidr_blocks = "0.0.0.0/0"
    }]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      name = "webserver"
      description = "webserver"
      cidr_blocks = var.subnet_cidr_block
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSh"
      name        = "SSH Connection"
      cidr_blocks = var.subnet_cidr_block
    }
  ]
} 

data "aws_ami" "aws-ubuntu-latest" {
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

resource "aws_instance" "ec2-ansible"{
  ami = data.aws_ami.aws-ubuntu-latest.id # "ami-052f10f1c45aa2155"
  instance_type = var.instance_type
  key_name = aws_key_pair.ssh_key.key_name
  tags = {
        Name="ec2-Ansible"
    }

  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.dev-sg.security_group_id]
  availability_zone = var.availability_zone
  
  associate_public_ip_address=true

    #install docker on the instance and run nginx
    #The script in user_data will only be executed once (at the instance creation time), not after every update of the configuration
   user_data = file("docker-install.sh")
    /* <<EOF
                   #!/bin/bash
                   sudo apt-get update -y && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
                   sudo systemctl start docker
                   sudo usermod -aG docker ubuntu
                   docker run -p 8080:80 nginx

                EOF*/
}

output "public_ip" {
  value = aws_instance.ec2-ansible.public_ip
}