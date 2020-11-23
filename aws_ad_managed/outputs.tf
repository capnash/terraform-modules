output "ad_connection_id" {
  value = aws_directory_service_directory.ad.id
}

output "ad_dns_ips" {
  value = aws_directory_service_directory.ad.dns_ip_addresses
}

output "ad_sg_id" {
  value = aws_directory_service_directory.ad.security_group_id
}

output "ad_access_url" {
  value = aws_directory_service_directory.ad.access_url
}

output "ad_name" {
  value = aws_directory_service_directory.ad.name
}

output "ad_alias" {
  value = aws_directory_service_directory.ad.alias
}