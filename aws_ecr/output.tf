output "ecr_arn" {
  value = "${aws_ecr_repository.repo.*.arn}"
}

output "ecr_name" {
  value = "${aws_ecr_repository.repo.*.name}"
}

output "ecr_registry_id" {
  value = "${aws_ecr_repository.repo.*.registry_id}"
}

output "ecr_repository_url" {
  value = "${aws_ecr_repository.repo.*.repository_url}"
}