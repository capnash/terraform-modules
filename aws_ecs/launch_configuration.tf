resource "aws_launch_configuration" "launch" {
  ebs_optimized         = var.ebs_optimized
  
  iam_instance_profile  = aws_iam_instance_profile.profile.id
  image_id              = var.aws_ami
  
  enable_monitoring     = var.instance_monitoring
  instance_type         = var.instance_type
  # security_groups       = [compact(concat(list(aws_security_group.instance.id), var.other_security_groups))]
  security_groups       = [aws_security_group.instance.id]
  
  name_prefix           = "${var.environment}-aws-ecs-lc-"
  key_name              = var.key_name

  associate_public_ip_address = false

  #user_data            = data.template_file.user_data.rendered
  user_data            = templatefile("${path.module}/files/user_data.sh", { ecs_config = var.ecs_config, ecs_logging = var.ecs_logging, cluster_name = aws_ecs_cluster.cluster.name, custom_userdata = var.custom_userdata, cloudwatch_prefix = "${var.environment}-aws-ecs", time_zone_path = var.time_zone_path }) 
  
  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_size
    delete_on_termination = var.delete_on_termination
  }

  # aws_launch_configuration can not be modified.
  # Therefore we use create_before_destroy so that a new modified aws_launch_configuration can be created 
  # before the old one get's destroyed. That's why we use name_prefix instead of name.
  lifecycle {
    create_before_destroy = true
  }
}

#############
## Outputs ##
#############
output "launch_configuration_ecs_id" {
  value = aws_launch_configuration.launch.id
}

output "launch_configuration_ecs_name" {
  value = aws_launch_configuration.launch.name
}

output "launch_configuration_ecs_arn" {
  value = aws_launch_configuration.launch.arn
}