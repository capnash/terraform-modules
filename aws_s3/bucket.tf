resource "aws_s3_bucket" "kms_bucket" {
  count  = var.encrypt && var.enabled ? 1 : 0
  bucket = var.name
  acl    = var.acl

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.kms_key_arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Id": "Encrypt",
    "Statement": [
        {
            "Sid": "DenyIncorrectEncryptionHeader",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${var.name}/*",
            "Condition": {
                "StringNotEquals": {
                    "s3:x-amz-server-side-encryption": "aws:kms"
                }
            }
        },
        {
            "Sid": "DenyUnEncryptedObjectUploads",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${var.name}/*",
            "Condition": {
                "Null": {
                    "s3:x-amz-server-side-encryption": "true"
                }
            }
        }
    ]
}
EOF
  tags = merge(var.tags, map("Name", var.name))

  versioning {
    enabled = var.versioning
  }

  lifecycle_rule {
    id      = "Remove old"
    prefix  = var.lc_remove_old_prefix
    enabled = var.lc_remove_old_enabled

    noncurrent_version_expiration {
      days  = var.lc_remove_old_days
    }
  }
}

resource "aws_s3_bucket" "bucket" {
  count  = var.encrypt && var.enabled ? 0 : 1
  bucket = var.name
  acl    = var.acl
  
  tags = merge(var.tags, map("Name", var.name))

  versioning {
    enabled = var.versioning
  }

  lifecycle_rule {
    id      = "Remove old"
    prefix  = var.lc_remove_old_prefix
    enabled = var.lc_remove_old_enabled

    noncurrent_version_expiration {
      days  = var.lc_remove_old_days
    }
  }
  
}

