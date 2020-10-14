output "kms_s3_bucket_id" {
  value = join(",", aws_s3_bucket.kms_bucket[*].id)
}

output "kms_s3_bucket_arn" {
  value = join(",", aws_s3_bucket.kms_bucket[*].arn)
}

output "kms_s3_bucket_region" {
  value = join(",", aws_s3_bucket.kms_bucket[*].region)
}

output "s3_bucket_id" {
  value = join(",", aws_s3_bucket.bucket[*].id)
}

output "s3_bucket_arn" {
  value = join(",", aws_s3_bucket.bucket[*].arn)
}

output "s3_bucket_region" {
  value = join(",", aws_s3_bucket.bucket[*].region)
}