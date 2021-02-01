resource "aws_ecr_repository" "repo" {
  count = "${var.enabled ? 1 : 0}"
  name = "${var.repo_name}"
  tags = "${var.tags}"
}

resource "aws_ecr_repository_policy" "repo_policy" {
  count = "${var.enabled ? 1 : 0}"
  repository = "${aws_ecr_repository.repo.name}"

  policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
      {
          "Sid": "AllowPushPull",
          "Effect": "Allow",
          "Principal":{
                "AWS": "arn:aws:iam::${var.account_id}:root"
            },
          "Action": [
              "ecr:BatchCheckLayerAvailability",
              "ecr:BatchGetImage",
              "ecr:CompleteLayerUpload",
              "ecr:GetDownloadUrlForLayer",
              "ecr:InitiateLayerUpload",
              "ecr:PutImage",
              "ecr:UploadLayerPart"
          ]
      }
  ]
}
EOF
}

resource "aws_ecr_lifecycle_policy" "repo_policy" {
  count = "${var.enabled ? 1 : 0}"
  repository = "${aws_ecr_repository.repo.name}"

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": ${var.lc_rule_priority},
      "description": "Expire untagged images older than ${var.lc_expire_days} days",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": ${var.lc_expire_days}
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}