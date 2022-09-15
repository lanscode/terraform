resource "aws_instance" "MyFirstInstance"{
    //count = 3 //number of instances to create
    ami = lookup(var.AMIS,var.AWS_REGION) //find this value in aws ami locator, the corresponding value of your selected region
    instance_type = "t2.micro"   

    tags={ //nested block
       // Name="instance-${count.index}" //instance name
          Name="instance"
    } 

}