resource "aws_directory_service_directory" "ad" {
  name        = var.ad_domain
  type        = var.domain_type
  description = var.ad_description
  edition     = var.edition
  enable_sso  = var.enable_sso
  alias       = var.ad_alias
  password    = var.ad_password

  vpc_settings {
    vpc_id     = var.vpc_id
    subnet_ids = var.subnets
  }

  tags = "${merge(var.tags, map("Name", format("%s-ad", var.ad_domain)))}"
}