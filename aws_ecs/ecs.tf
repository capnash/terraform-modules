resource "aws_ecs_cluster" "cluster" {
  name = "${var.environment}-aws-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  
  tags = merge(var.tags, map("Name", "${var.environment}-aws-ecs-cluster"))
  
}

#############
## Outputs ##
#############
output "ecs_cluster_name" {
  value = "${aws_ecs_cluster.cluster.name}"
}

output "ecs_cluster_id" {
  value = "${aws_ecs_cluster.cluster.id}"
}

output "ecs_cluster_arn" {
  value = "${aws_ecs_cluster.cluster.arn}"
}