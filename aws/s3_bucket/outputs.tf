output "name" {
    value = "${element(concat(aws_s3_bucket.s3_bucket.*.bucket,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_s3_bucket.s3_bucket.*.arn,list("")),0)}"
}

output "id" {
    value = "${element(concat(aws_s3_bucket.s3_bucket.*.id,list("")),0)}"
}

output "dns_name" {
    value = "${element(concat(aws_s3_bucket.s3_bucket.*.bucket_domain_name,list("")),0)}"
}

output "web_address" {
    value = "${element(concat(aws_s3_bucket.s3_bucket.*.website_endpoint,list("")),0)}"
}

output "zone" {
    value = "${element(concat(aws_s3_bucket.s3_bucket.*.hosted_zone_id,list("")),0)}"
}
