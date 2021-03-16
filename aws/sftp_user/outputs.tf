output "user_name" {
  value = "${element(concat(aws_transfer_user.sftp_user.*.user_name,list("")),0)}"
}
