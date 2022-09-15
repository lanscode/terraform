resource "aws_s3_bucket" "koria-s3bucket"{
    bucket = "koria-s3-bucket"
    tags = { 
        Name = "koria-s3-bucket"
    }
}
resource "aws_s3_bucket_acl" "koria_bucket_acl" {
  bucket = aws_s3_bucket.koria-s3bucket.id
  acl    = "private"
}