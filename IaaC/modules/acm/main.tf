resource "aws_acm_certificate" "cert" {
  domain_name = var.domain_name
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Environment = var.env
    Project     = "nodejs-eks"
    ManagedBy   = "Terraform"
    Purpose    = "SSL Certificate"
    Team       = "DevOps"
  }
}

resource "cloudflare_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      value  = dvo.resource_record_value
    }
  }

  zone_id = var.cloudflare_zone_id
  name    = trimsuffix(each.value.name, ".")    
  type    = each.value.type
  content = trimsuffix(each.value.value, ".")
  ttl     = 300
  # no cross-module dependency required here; Cloudflare DNS records don't depend on the VPC
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  # Use the domain validation option names returned by ACM directly. Cloudflare record
  # resource does not expose `fqdn`, so derive the fqdns from the ACM response.
  validation_record_fqdns = [for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.resource_record_name]
}