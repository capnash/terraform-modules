###### TAGS #####
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = "map"
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = "string"
}

variable "acl" {
  description = "ACL to apply to bucket"
  default     = "private"
}

variable "kms_key_arn" {
  description = " KMS Key to use for server side encryption"
  type        = "string"
}

variable "encrypt" {
  description = "Encrypt the s3 bucket at rest"
  type        = "string"
  default     = true
}

variable "enabled" {
  description = "Encrypt the s3 bucket at rest"
  type        = "string"
  default     = true
}

variable "lc_remove_old_prefix" {
  description = "Life Cycle rule to delete objects prefix, default /"
  default     = "/"
  type        = "string"
}

variable "lc_remove_old_enabled" {
  description = "Life Cycle rule to delete objects enabled or disabled. Default is false"
  default     = false
}

variable "lc_remove_old_days" {
  description = "Life Cycle rule to delete objects number of days since created to delete, default 14 days"
  default     = 14
}

variable "versioning" {
  description = "keeping multiple variants of an object in the same bucket"
  default     = false
}
