terraform{
    backend "s3"{
        bucket = "koria-terra-bucket"
        key = "developpement/terraform-state"
        region = "eu-west-3"
    }
}