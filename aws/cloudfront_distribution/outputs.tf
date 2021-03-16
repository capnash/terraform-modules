output "id" {
    value = "${element(concat(aws_cloudfront_distribution.cloudfront_distribution.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_cloudfront_distribution.cloudfront_distribution.*.arn,list("")),0)}"
}

output "status" {
    value = "${element(concat(aws_cloudfront_distribution.cloudfront_distribution.*.status,list("")),0)}"
}

output "domain_name" {
    value = "${element(concat(aws_cloudfront_distribution.cloudfront_distribution.*.domain_name,list("")),0)}"
}

output "zone" {
    value = "${element(concat(aws_cloudfront_distribution.cloudfront_distribution.*.hosted_zone_id,list("")),0)}"
}
