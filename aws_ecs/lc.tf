resource "aws_launch_configuration" "launch" {
  ebs_optimized         = var.ebs_optimized
  
  iam_instance_profile  = aws_iam_instance_profile.profile.id
  image_id              = var.aws_ami
  
  enable_monitoring     = var.instance_monitoring
  instance_type         = var.instance_type
  security_groups       = ["${compact(concat(list("${aws_security_group.instance.id}"), "${var.other_security_groups}"))}"]
  
  name_prefix           = var.name
  key_name              = var.key_name

  associate_public_ip_address = false

  user_data            = data.template_file.user_data.rendered

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
output "lc_id" {
  value = "${aws_launch_configuration.launch.id}"
}

output "lc_name" {
  value = "${aws_launch_configuration.launch.name}"
}