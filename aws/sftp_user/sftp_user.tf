resource "aws_transfer_user" "sftp_user" {
  server_id = var.sftp_server_id
  user_name = var.sftp_user_name
  role = var.sftp_server_role_arn
  home_directory = "/${var.bucket_name}/${var.directory}"
}