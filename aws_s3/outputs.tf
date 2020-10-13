output "kms_s3_bucket_id" {
  value = aws_s3_bucket.kms_bucket[0].id
}

output "kms_s3_bucket_arn" {
  value = aws_s3_bucket.kms_bucket[0].arn
}

output "kms_s3_bucket_region" {
  value = aws_s3_bucket.kms_bucket[0].region
}

output "s3_bucket_id" {
  value = aws_s3_bucket.bucket[0].id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.bucket[0].arn
}

output "s3_bucket_region" {
  value = aws_s3_bucket.bucket[0].region
}