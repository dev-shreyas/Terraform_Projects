locals {
  addons = {}
}

output "addons" {
  value = local.addons
  description = "A map of addons to be installed on the EKS cluster"
  sensitive = false
  depends_on = [module.eks]
}