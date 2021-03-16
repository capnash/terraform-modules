resource "aws_transfer_server" "sftp_server" {

  identity_provider_type = "SERVICE_MANAGED"  

  tags = {
    Name = "${var.caller}-${var.name}"
    Description = var.description
    Environment = "${var.caller}"
    Service = var.svc
  }
}
