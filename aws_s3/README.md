# AWS_s3 Module

Basic module for terraform that creates s3 bucket with basic and standard configureation.

I.e. tagging and or encryption

Must provide a list of map of tags that will be applied to bucket.

By default bucket is using Server side encryption using KMS key, you must provide the KMS key ARN

You can enable baisc life cycle rule and by default it removes old files after 14 days.
