variable "env" {
  description = "The environment for tagging purposes" 
  type        = string
}

variable "repository_image_tag_mutability" {
  description = "The image tag mutability setting for the ECR repository"
  type        = string
}

variable "repository_encryption_type" {
  description = "The encryption type for the ECR repository"
  type        = string
}