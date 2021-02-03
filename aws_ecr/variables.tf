variable "repo_name" {
  description = "Name of Docker Repo"
  type        = "string"
}

variable "lc_rule_priority" {
  description = "Life Cycle Rule priority"
  type        = "string"
  default     = 1
}

variable "lc_expire_days" {
  description = "Life Cycle Rule - number of days to expirer untagged image sinceImagePushed"
  type        = "string"
  default     = 14
}

variable "account_id" {
  description = "The aws account id that will have access to the repo"
  type        = "string"
}

variable "enabled" {
  description = "service enabled"
  default     = "true"
}

variable "tags" {
  description = "map of tags"
  type        = "map"
}

variable "environment" {
  description = "Environment that service is being built in"
  type        = string
}