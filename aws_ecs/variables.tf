##### TAGS #####
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map
}

variable "environment" {
  description = "Environment that service is being built in"
  type        = string
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

variable "metrics" {
  description = "A list of metrics to collect."
  type        = list
  default     = ["GroupDesiredCapacity", "GroupInServiceCapacity", "GroupPendingCapacity", "GroupMinSize", "GroupMaxSize", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupStandbyCapacity", "GroupTerminatingCapacity", "GroupTerminatingInstances", "GroupTotalCapacity", "GroupTotalInstances"]
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

variable "cpu_scaling_out_adjustment" {
  description = "Adjustment amount"
  type        = string
  default     = 1
}

variable "cpu_scaling_in_adjustment" {
  description = "Adjustment amount"
  type        = string
  default     = -1
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

##### Launch Config #####
variable "ebs_optimized" {
  description = " If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = false
}

variable "aws_ami" {
  description = "AMI ID to use in luanch config"
  type        = string
}

variable "instance_monitoring" {
  description = "Enables/disables detailed monitoring. This is enabled by default."
  type        = bool
  default     = true
}

variable "instance_type" {
  description = "The size of the instance to spin up"
  type        = string
}

variable "other_security_groups" {
  description = "If you require any other sg attached, provide list of ID's"
  type        = list
  default     = [""]
}

variable "key_name" {
  description = "SSH key for instances"
  type        = string
}

variable "volume_type" {
  description  = "The type of volume"
  type        = string
  default     = "gp2"
}

variable "volume_size" {
  description = "The size of the volume in gigabytes"
  type        = string
  default     = 30
}

variable "delete_on_termination" {
  description = "Whether the volume should be destroyed on instance termination"
  type        = bool
  default     = true
}

# #### Main.tf #####

variable "ecs_config" {
  description = "Specify ecs configuration or get it from S3. Example: aws s3 cp s3://some-bucket/ecs.config /etc/ecs/ecs.config"
  type        = string
  default     = "echo '' > /etc/ecs/ecs.config"
}

variable "ecs_logging" {
  description = "Adding logging option to ECS that the Docker containers can use. It is possible to add fluentd as well"
  type        = string
  default     = "[\"json-file\",\"awslogs\"]"
}

variable "custom_userdata" {
  description = "Inject extra command in the instance template to be run on boot"
  type        = string
  default     = ""
}

variable "time_zone_path" {
  description = "path in linux to correct time zone"
  type        = string
  default     = "/usr/share/zoneinfo/Europe/London"
}

# ##### Lambda #####

variable "lambda_kms_key_arn" { 
  description = "The lambda KMS Key arn"
  type        = string
}

variable "slack_channel" {
  description = "The channel of slack to send notifications to eg #devops."
  type        = string
}

variable "slack_weebhook_path" {
  description = "The webhook path of slack to send notifications to."
  type        = string
}

##### Security Groups #####
variable "vpc_id" {
  description = "The ID of the vpc to add ALB to"
  type        = string
}

variable "alb_sg_id" {
   description = "Security Group ID of the ALB"
   type        = string
}

##### IAM #####
variable "ecs_service_role_name" {
   description = "Name for the Ecs Service Role (only change if you need to override the default name)"
   type        = string
   default     = "ecs_service_role"
}
