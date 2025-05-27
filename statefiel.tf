terraform {
  backend "s3" {
    bucket         = "qtree-remote-state" // update terraform remote state bucket name
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }

}
resource "aws_s3_bucket" "project" {
  bucket = "testqtreedata4456"     //update your unique bucket name          
  
}
resource "aws_s3_bucket_versioning" "project" {
  bucket = aws_s3_bucket.project.bucket
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_lifecycle_configuration" "project_lifecycle" {
  rule {
    id      = "project_rule"
    status  = "Enabled"
    transition {
      days          = 30
      storage_class = "GLACIER"
    }
    expiration {
      days = 365
    }
  }
  bucket = aws_s3_bucket.project.bucket
  depends_on = [aws_s3_bucket.project]
}

