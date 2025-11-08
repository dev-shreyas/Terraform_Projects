terraform {
  backend "s3" {
    bucket = "tf-state-managed-bucket"
    key    = "dev/eks/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
    encrypt = true
  }
}