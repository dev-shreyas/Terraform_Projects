locals {
  azs = ["us-east-1a", "us-east-1d", "us-east-1f"]
}

module "vpc" {
  source                = "../../modules/vpc"
  vpc_name              = "dev-vpc"
  vpc_cidr              = "10.0.0.0/16"
  # Ensure the number of AZs matches the number of subnets provided (3)
  # Avoid AZs unsupported by EKS control plane (us-east-1e). Use allowed AZs instead.
  vpc_azs               = local.azs
  vpc_private_subnets   = [for i in range(length(local.azs)) : cidrsubnet("10.0.0.0/16", 2, i)]
  vpc_public_subnets    = [for i in range(length(local.azs)) : cidrsubnet("10.0.192.0/24", 2,i)]
}

module "eks" {
  source = "../../modules/eks"
  cluster_name          = "dev-eks-cluster"
  kubernetes_version    = "1.34"
  vpc_ids                = [module.vpc.vpc_id]
  subnet_ids            = module.vpc.private_subnets
  environment           = "dev"
}