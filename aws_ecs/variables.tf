##### TAGS #####
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "time_zone_path" {
  description = "path in linux to correct time zone"
  type        = string
  default     = "/usr/share/zoneinfo/Europe/London"
}

##### Autoscaling #####

variable "asg_max" {
  description = "Max number of instances to spin up"
  type        = string
  default     = 2
}

variable "asg_min" {
  description = "Min number of instances to spin up"
  type        = string
  default     = 1
}

variable "asg_desired" {
  description = "Starting number of instances to spin up"
  type        = string
  default     = 1
}

variable "metrics_granularity" {
  description = "The granularity to associate with the metrics to collect. The only valid value is 1Minute"
  type        = string
  default     = "1Minute"
}

variable "private_subnets" {
  description = "List of Subnets to autoscale into"
  type        = list
}

variable "cpu_adjustment_type" {
  description = "Adjustment type: ChangeInCapacity, ExactCapacity, PercentChangeInCapacity"
  type        = string
  default     = "ChangeInCapacity"
}

variable "cpu_scaling_adjustment" {
  description = "Adjustment amount"
  type        = string
  default     = 1
}

variable "cpu_cooldown" {
  description = "Cooldown period in seconds for the cpu policy"
  type        = string
  default     = 300
}

variable "cpu_policy_type" {
  description = "SimpleScaling, StepScaling, TargetTrackingScaling"
  type        = string
  default     = "SimpleScaling"
}

variable "cpu_scale_out_comparison_operator" {
  description = "GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold"
  type        = string
  default     = "GreaterThanThreshold"
}

variable "cpu_evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold"
  type        = string
  default     = 2
}

variable "cpu_period" {
  description = "The period in seconds over which the specified statistic is applied"
  type        = string
  default     = 120
}

variable "cpu_scale_out_threshold" {
  description = "The value against which the specified statistic is compared"
  type        = string
  default     = 70
}

variable "cpu_scale_in_comparison_operator" {
  description = "GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold"
  type        = string
  default     = "LessThanOrEqualToThreshold"
}

variable "cpu_scale_in_threshold" {
  description = "The value against which the specified statistic is compared"
  type        = string
  default     = 45
}

variable "scale_out_time" {
  description = "Cron time when ASG scales out (example: '0 11 * * mon-fri'"
  type        = string
  default     = "none"
}

variable "scale_in_time" {
  description = "Cron time when ASG scales in"
  type        = string
  default     = "none"
}

variable "mem_adjustment_type" {
  description = "Adjustment type: ChangeInCapacity, ExactCapacity, PercentChangeInCapacity"
  type        = string
  default     = "ChangeInCapacity"
}

variable "mem_scaling_adjustment" {
  description = "Adjustment amount"
  type        = string
  default     = 1
}

variable "mem_cooldown" {
  description = "Cooldown period in seconds for the mem policy"
  type        = string
  default     = 300
}

variable "mem_policy_type" {
  description = "SimpleScaling, StepScaling, TargetTrackingScaling"
  type        = string
  default     = "SimpleScaling"
}

variable "mem_scale_out_comparison_operator" {
  description = "GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold"
  type        = string
  default     = "LessThanThreshold"
}

variable "mem_evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold"
  type        = string
  default     = 3
}

variable "mem_period" {
  description = "The period in seconds over which the specified statistic is applied"
  type        = string
  default     = 60
}

variable "mem_scale_out_threshold" {
  description = "The value against which the specified statistic is compared"
  type        = string
  default     = 40
}

variable "mem_scale_in_comparison_operator" {
  description = "GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold"
  type        = string
  default     = "GreaterThanThreshold"
}

variable "mem_scale_in_threshold" {
  description = "The value against which the specified statistic is compared"
  type        = string
  default     = 70
}

# variable "memory_low_alarm" {
#   description = "Threshold for low memory utilization"
#   type        = string
#   default     = 40
# }

# variable "memory_high_alarm" {
#   description = "Threshold for high memory utilization"
#   type        = string
#   default     = 70
# }

# ##### Launch Config #####
# variable "ebs_optimized" {
#   description = " If true, the launched EC2 instance will be EBS-optimized"
#   default     = false
# }

# variable "aws_ami" {
#   description = "AMI ID to use in luanch config"
#   default     = "ami-acb020d5"
# }

# variable "instance_monitoring" {
#   description = "Enables/disables detailed monitoring. This is enabled by default."
#   default     = true
# }

# variable "instance_type" {
#   description = "The size of the instance to spin up"
#   type        = "string"
# }

# variable "other_security_groups" {
#   description = "If you require any other sg attached, provide list of ID's"
#   default     = [""]
# }

# variable "key_name" {
#   description = "SSH key for instances"
#   type        = "string"
#   default     = ""
# }

# variable "volume_type" {
#   description  = "The type of volume"
#   type        = "string"
#   default     = "gp2"
# }

# variable "volume_size" {
#   description = "The size of the volume in gigabytes"
#   type        = "string"
#   default     = "30"
# }

# variable "delete_on_termination" {
#   description = "Whether the volume should be destroyed on instance termination"
#   type        = "string"
#   default     = "true"
# }

# #### Main.tf #####

# variable "ecs_config" {
#   default     = "echo '' > /etc/ecs/ecs.config"
#   description = "Specify ecs configuration or get it from S3. Example: aws s3 cp s3://some-bucket/ecs.config /etc/ecs/ecs.config"
# }

# variable "ecs_logging" {
#   default     = "[\"json-file\",\"awslogs\",\"splunk\"]"
#   description = "Adding logging option to ECS that the Docker containers can use. It is possible to add fluentd as well"
# }

# variable "custom_userdata" {
#   default     = ""
#   description = "Inject extra command in the instance template to be run on boot"
# }

# ##### Lambda #####

variable "lambda_kms_key_arn" { 
  description = "The lambda KMS Key arn"
  type        = string
}

variable "slack_channel" {
  description = "The channel of slack to send notifications to."
  type        = string
}

variable "slack_weebhook_path" {
  description = "The webhook path of slack to send notifications to."
  type        = string
}

# ##### Security Groups #####
# variable "vpc_id" {
#   description = "The ID of the vpc to add ALB to"
# }


# ##### ALB #####
# variable "alb_sg_id" {
#    description = "Security Group ID of the ALB"
#    type        = "string"
# }

# ##### IAM #####
# variable "ecs_service_role_name" {
#    description = "Name for the Ecs Service Role (only change if you need to override the default name)"
#    type        = "string"
#    default     = "ecsServiceRole"
# }

# variable "prod_account_id"{
#   description = "Production ID for aws account"
#   type        = "string"
# }

variable "environment" {
  description = "Environment that service is being built in"
  type        = string
}