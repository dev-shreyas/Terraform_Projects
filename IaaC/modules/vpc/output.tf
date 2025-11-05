output "name" {
  value = module.vpc.name
}

output "id" {
  value = module.vpc.id
}

output "cidr" {
  value = module.vpc.cidr
}

output "azs" {
  value = module.vpc.azs
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "enable_nat_gateway" {
  value = module.vpc.enable_nat_gateway
}

output "enable_vpn_gateway" {
  value = module.vpc.enable_vpn_gateway
}