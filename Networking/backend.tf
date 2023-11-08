terraform {
 backend "s3" {
    bucket         = "jllg18-terraform-state-bucket"
    key            = "path/to/my/key"
    region         = "us-east-1"
    encrypt        = true
 }
}