variable "AWS_ACCESS_KEY"  {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
    default = "eu-west-3"
}

variable "sg-name"{}
variable "subnet_cidr_block"{}
variable "vpc_cidr_block"{}
variable "instance_type"{}
variable "availability_zone"{}
variable "env-prefix"{}

variable "PATH_TO_PRIVATE_KEY"{
    default="ansible_aws_key"
}
variable "PATH_TO_PUBLIC_KEY"{
    default="ansible_aws_key.pub"
}

