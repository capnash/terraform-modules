##### ECS #####

output "ecs_cluster_name" {
  value = "${aws_ecs_cluster.cluster.name}"
}

output "ecs_cluster_id" {
  value = "${aws_ecs_cluster.cluster.id}"
}

output "ecs_cluster_arn" {
  value = "${aws_ecs_cluster.cluster.arn}"
}

##### Autoscaling Group #####

output "asg_id" {
  value = "${aws_autoscaling_group.asg.id}"
}
 
output "asg_arn" {
  value = "${aws_autoscaling_group.asg.arn}"
}

output "asg_name" {
  value = "${aws_autoscaling_group.asg.name}"
}

output "asg_policy_in_arn" {
  value = "${aws_autoscaling_policy.scale_in_policy.arn}"
}
output "asg_policy_in_name" {
  value = "${aws_autoscaling_policy.scale_in_policy.name}"
}

output "asg_policy_out_arn" {
  value = "${aws_autoscaling_policy.scale_out_policy.arn}"
}

output "asg_policy_out_name" {
  value = "${aws_autoscaling_policy.scale_out_policy.name}"
}


##### Cloudwatch #####
output "cw_alarm_low_memory_id" {
  value = "${aws_cloudwatch_metric_alarm.memory_low_alarm.id}"
}

output "cw_alarm_low_memory_alarm_name" {
  value = "${aws_cloudwatch_metric_alarm.memory_low_alarm.alarm_name}"
}


##### launch config #####
output "lc_id" {
  value = "${aws_launch_configuration.launch.id}"
}

output "lc_name" {
  value = "${aws_launch_configuration.launch.name}"
}


##### Security Groups #####
output "sg_ecs_instance_id" {
  value = "${aws_security_group.instance.id}"
}

output "sg_ecs_instance_name" {
  value = "${aws_security_group.instance.name}"
}

output "sg_ecs_instance_arn" {
  value = "${aws_security_group.instance.arn}"
}


##### IAM #####
output "ecs_instance_profile_id" {
  value = "${aws_iam_instance_profile.profile.id}"
}

output "ecs_instance_profile_name" {
  value = "${aws_iam_instance_profile.profile.name}"
}

output "ecs_instance_profile_arn" {
  value = "${aws_iam_instance_profile.profile.arn}"
}

output "ecs_role_name" {
  value = "${aws_iam_role.role.name}"
}

output "ecs_role_arn" {
  value = "${aws_iam_role.role.arn}"
}

output "ecs_execution_role_name" {
  value = "${aws_iam_role.ecs_execution_role.name}"
}

output "ecs_execution_role_arn" {
  value = "${aws_iam_role.ecs_execution_role.arn}"
}

output "ecs_autoscale_role_name" {
  value = "${aws_iam_role.ecs_autoscale_role.name}"
}

output "ecs_autoscale_role_arn" {
  value = "${aws_iam_role.ecs_autoscale_role.arn}"
}

output "ecsServiceRole_name" {
  value = "${aws_iam_role.ecsServiceRole.name}"
}

output "ecsServiceRole_arn" {
  value = "${aws_iam_role.ecsServiceRole.arn}"
}

output "notifications_role_name" {
  value = "${aws_iam_role.notifications_role.name}"
}

output "notifications_role_arn" {
  value = "${aws_iam_role.notifications_role.arn}"
}

output "lambda_execution_role_name" {
  value = "${aws_iam_role.lambda_execution_role.name}"
}

output "lambda_execution_role_arn" {
  value = "${aws_iam_role.lambda_execution_role.arn}"
}

##### SNS #####
output "sns_ecs_lifecycle_subscription_id" {
  value = "${aws_sns_topic_subscription.ecs_lifecycle_subscription.id}"
}

output "sns_ecs_lifecycle_subscription_topic_arn" {
  value = "${aws_sns_topic_subscription.ecs_lifecycle_subscription.topic_arn}"
}

output "sns_ecs_lifecycle_subscription_endpoint" {
  value = "${aws_sns_topic_subscription.ecs_lifecycle_subscription.endpoint}"
}

output "sns_ecs_lifecycle_subscription_arn" {
  value = "${aws_sns_topic_subscription.ecs_lifecycle_subscription.arn}"
}

output "sns_ecs_lifecycle_topic_id" {
  value = "${aws_sns_topic.ecs_lifecycle_topic.id}"
}

output "sns_ecs_lifecycle_topic_arn" {
  value = "${aws_sns_topic.ecs_lifecycle_topic.arn}"
}

##### Lambda #####
output "lambda_ecs_lifecycle_function_arn" {
   value = "${aws_lambda_function.ecs_lifecycle_function.arn}"
}

output "lambda_ecs_lifecycle_function_qualified_arn" {
   value = "${aws_lambda_function.ecs_lifecycle_function.qualified_arn}"
}

output "lambda_ecs_lifecycle_function_invoke_arn" {
   value = "${aws_lambda_function.ecs_lifecycle_function.invoke_arn}"
}

output "lambda_ecs_lifecycle_function_version" {
   value = "${aws_lambda_function.ecs_lifecycle_function.version}"
}



##### Public ALB #####

# output "alb_tg_default_public_arn" {
#   value = "${aws_alb_target_group.default_public.arn}"
# }

# output "alb_tg_default_public_name" {
#   value = "${aws_alb_target_group.default_public.name}"
# }

# output "alb_tg_default_public_id" {
#   value = "${aws_alb_target_group.default_public.id}"
# }

# output "alb_tg_default_public_https_arn" {
#   value = "${aws_alb_target_group.default_public_https.arn}"
# }

# output "alb_tg_default_public_https_name" {
#   value = "${aws_alb_target_group.default_public_https.name}"
# }

# output "alb_tg_default_public_https_id" {
#   value = "${aws_alb_target_group.default_public_https.id}"
# }

# output "alb_arn_public" {
#   value = "${aws_alb.alb_public.arn}"
# }

# output "alb_dns_public" {
#   value = "${aws_alb.alb_public.dns_name}"
# }

# output "alb_zone_public_id" {
#   value = "${aws_alb.alb_public.zone_id}"
# }

# output "alb_listener_http_public_id" {
#   value = "${aws_alb_listener.http_public.id}"
# }

# output "pub_alb_listeners_arn" {
#   value = ["${aws_alb_listener.http_public.arn}", "${aws_alb_listener.https_public.arn}"]
# }

# output "alb_listener_http_public_arn" {
#   value = "${aws_alb_listener.http_public.arn}"
# }

# output "alb_listener_https_public_id" {
#   value = "${aws_alb_listener.https_public.id}"
# }

# output "alb_listener_https_public_arn" {
#   value = "${aws_alb_listener.https_public.arn}"
# }

# ##### Private ALB #####

# output "alb_tg_default_private_arn" {
#   value = "${aws_alb_target_group.default_private.arn}"
# }

# output "alb_tg_default_private_name" {
#   value = "${aws_alb_target_group.default_private.name}"
# }

# output "alb_tg_default_private_id" {
#   value = "${aws_alb_target_group.default_private.id}"
# }

# output "alb_tg_default_private_https_arn" {
#   value = "${aws_alb_target_group.default_private_https.arn}"
# }

# output "alb_tg_default_private_https_name" {
#   value = "${aws_alb_target_group.default_private_https.name}"
# }

# output "alb_tg_default_private_https_id" {
#   value = "${aws_alb_target_group.default_private_https.id}"
# }

# output "alb_arn_private" {
#   value = "${aws_alb.alb_private.arn}"
# }

# output "alb_dns_private" {
#   value = "${aws_alb.alb_private.dns_name}"
# }

# output "alb_zone_private_id" {
#   value = "${aws_alb.alb_private.zone_id}"
# }

# output "alb_listener_http_private_id" {
#   value = "${aws_alb_listener.http_private.id}"
# }

# output "alb_listener_http_private_arn" {
#   value = "${aws_alb_listener.http_private.arn}"
# }

# output "alb_listener_https_private_id" {
#   value = "${aws_alb_listener.https_private.id}"
# }

# output "alb_listener_https_private_arn" {
#   value = "${aws_alb_listener.https_private.arn}"
# }
