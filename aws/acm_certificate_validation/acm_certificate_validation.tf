resource "aws_acm_certificate_validation" "acm_validator" {
  certificate_arn         = "${var.certificate}"
  validation_record_fqdns = "${var.fqdn}"
  count                   = "${local.farm}"
}