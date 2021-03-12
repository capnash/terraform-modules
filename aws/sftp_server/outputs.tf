output "id" {
  value = "${element(concat(aws_transfer_server.sftp_server.*.id,list("")),0)}"
}

output "endpoint" {
  value = "${element(concat(aws_transfer_server.sftp_server.*.endpoint,list("")),0)}"
}