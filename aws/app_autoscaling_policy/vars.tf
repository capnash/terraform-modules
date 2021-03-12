variable "name" {}

variable "caller" {}

variable "dimension" {}

variable "namespace" {}

variable "resource_id" {}

variable "policy_type" {}

variable "target_tracking_scaling_policy_configuration" {
    default = []
}

locals {
    defaults = {
        target_tracking_scaling_policy_configuration = {
            predefined_metric_specification = []
            target_value = 90
        }
        predefined_metric_specification = {
            predefined_metric_type = null
        }
    }
}
