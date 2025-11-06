terraform {
  backend "s3" {
    bucket = "tf-state-managed-bucket"
    key    = "dev/eks/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "tf-lock-table"
    encrypt = true
  }
}