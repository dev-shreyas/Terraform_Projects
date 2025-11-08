variable "domain_name" {
  description = "The domain name for the ACM certificate"
  type        = string
}
variable "cloudflare_zone_id" {
  description = "The Cloudflare zone ID for DNS validation"
  type        = string
}
variable "env" {
  description = "The environment for tagging purposes"
  type        = string
}

variable "cloudflare_api_token" {
    description = "API token for Cloudflare provider"
    type        = string
    sensitive   = true
}