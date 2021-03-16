output "arn" {
    value = "${element(concat(aws_ecr_repository.ecr_repository.*.arn,list("")),0)}"
}

output "id" {
    value = "${element(concat(aws_ecr_repository.ecr_repository.*.registry_id,list("")),0)}"
}

output "url" {
    value = "${element(concat(aws_ecr_repository.ecr_repository.*.repository_url,list("")),0)}"
}