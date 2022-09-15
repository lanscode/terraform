/*resource "aws_s3_bucket" "bucket" {
  bucket = "koriabucket"
}
*/
resource "aws_instance" "MyFirstInstance"{
    count = 3 //create 3 instances of this machine
    ami = "ami-052f10f1c45aa2155" //find this value in aws ami locator, the corresponding value of your selected region
    instance_type = "t2.micro"   

    tags={ //nested block
        Name="instance-${count.index}" //instance name
    } 
}