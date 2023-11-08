variable region {
  type        = string
  default     = "us-east-1"
  description = "Virginia region"
}

data "aws_ssm_parameter" "terraform-access" {
    name = "/terraform/access_key"
  
}

data "aws_ssm_parameter" "terraform-secret" {
    name = "/terraform/secret_key"
}



