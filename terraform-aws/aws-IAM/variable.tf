variable "AWS_ACCESS_KEY"  {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
    default = "eu-west-3"
}
variable "DUMMY_SECURITY_GROUP"{
    type = list
    default = ["sg-1235","sg-1289","sg-659889"]
}
variable "AMIS"{
    type = map
    default= {eu-west-3="ami-052f10f1c45aa2155"
              eu-west-2="ami-0f98541a3c898423d"
              us-east-2="ami-097261bd06e355492"
    }
}

variable "PATH_TO_PRIVATE_KEY"{
    default="koria_aws_key"
}
variable "PATH_TO_PUBLIC_KEY"{
    default="koria_aws_key.pub"
}

variable "INSTANCE_USERNAME"{
    default="ubuntu"
}