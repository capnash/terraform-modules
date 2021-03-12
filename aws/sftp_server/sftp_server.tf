resource "aws_transfer_server" "sftp_server" {

  identity_provider_type = "SERVICE_MANAGED"  

  tags = {
    Name = "${upper(var.caller)}-${var.name}"
    Description = var.description
    Environment = "${upper(var.caller)}"
    Service = var.svc
  }
}
