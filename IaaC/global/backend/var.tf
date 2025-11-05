variable "region" {
  description = "The AWS region to deploy the infrastructure"
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket for Terraform state"
  default     = "tf-state-managed-bucket"
}

variable "lock_table" {
    description = "The name of the DynamoDB table for Terraform state locking"
    default     = "tf-lock-table"
}