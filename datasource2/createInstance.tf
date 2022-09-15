data "aws_availability_zones" "available" {}

data "aws_ami" "latest-ubuntu"{
   most_recent = true
   owners = ["099720109477"]
   filter {
    name="name"
     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
   }
   filter{
    name="virtualization-type"
    values=["hvm"]
   }
}
resource "aws_instance" "MyFirstInstance"{
    //count = 3 //number of instances to create
    ami = data.aws_ami.latest-ubuntu.id //find this value in aws ami locator, the corresponding value of your selected region
    instance_type = "t2.micro"   
    availability_zone = data.aws_availability_zones.available.names[1] # since in aws, the availibility_zones ares a, b,c and d, this line will take b::eu-west-3b
    tags={ //nested block
       // Name="instance-${count.index}" //instance name
          Name="instance"
    } 
    provisioner "local-exec" {
       command= "echo ${self.private_ip}>>myprivate_ip.txt"
    } 
}
output "public_ip" {
        value = aws_instance.MyFirstInstance.public_ip
    }
