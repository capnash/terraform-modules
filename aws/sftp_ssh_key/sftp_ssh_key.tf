resource "aws_transfer_ssh_key" "sftp_server_ssh_key" {
  server_id = var.sftp_server_id
  user_name = var.sftp_user_name
  body = var.sftp_server_ssh_key
}
