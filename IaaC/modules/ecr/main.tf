module "ecr" {
 source = "terraform-aws-modules/ecr/aws"
 version = "~> 2.0"

 repository_name = "${var.env}-ecr-repo"
 repository_image_tag_mutability = var.repository_image_tag_mutability
 repository_encryption_type = var.repository_encryption_type
  
 repository_lifecycle_policy = jsonencode({
   rules = [
     {
       rulePriority = 1
       description  = "Keep last 30 untagged images"
       selection = {
         tagStatus     = "untagged"
         countType     = "imageCountMoreThan"
         countNumber   = 30
       }
       action = {
         type = "expire"
       }
     },
     {
       rulePriority = 2
       description  = "Keep tagged images forever"
       selection = {
         tagStatus     = "tagged"
         tagPrefixList = ["v", "release", "latest"]
         countType     = "imageCountMoreThan"
         countNumber   = 999999
       }
       action = {
         type = "expire"
       }
     }
   ]
 })
  
    tags = {
        Environment = var.env
        Project     = "nodejs-eks"
    }
}