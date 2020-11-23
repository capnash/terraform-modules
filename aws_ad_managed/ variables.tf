# Ad Connection
variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
  type        = map
}

variable "ad_domain" {
  description = "Active Directory Domain FQDN"
  type        = string
}

variable "edition" {
  description = "Active Directory Domain type either Standard or Enterprise"
  type        = string
  default     = "Standard"
}

variable "enable_sso" {
  description = "Whether to enable single-sign on for the directory. Requires alias"
  type        = string
  default     = true
}

variable "ad_alias" {
  description = "The alias for the directory (must be unique amongst all aliases in AWS). Required for enable_sso"
  type        = string
}

variable "ad_password" {
  description = "Active Directory Domain Service Account Password"
  type        = string
}

variable "subnets" {
  description = "subnets to install ad connect into"
  type        = list
}

variable "vpc_id" {
  description = "VPC to install ad connect into"
  type        = string
}

variable "ad_description" {
  description = "A textual description for the directory"
  type        = string
  default     = "AD Connection"
}

variable "on_perm_dns_ips" {
  description = "Map of on-perm DNS server ips"
  type        = map
}

variable "domain_type" {
  description = "Type of managed domain from AWS"
  type        = string
  default     = "MicrosoftAD"
}
