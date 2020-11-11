# Module: aws_vpc

### THIS SHOULD ONLY BE EDITIED BY DEVOPS  

[![Version](https://img.shields.io/badge/version-0.0.7-brightgreen.svg)]()

This module is used when wanting to create the base network.
 
### This module will build the following with default variables:

 - _main.tf_
    - `aws_availability_zones` - Data resource
    - `aws_vpc_endpoint_service` - Data resource

 - _vpc.tf_
    -  __VPC__

        CIDR `10.0.0.0/23` (510 IP's)

        Instance Tenancy `default`

        DNS Hostnames `true`

        DNS Support `true`

        DHCP Option set defualts to use the one built with VPC

    -  __Network ACL__

       Renames the default Network ACL so that it is named

    - __DHCP Options__

      If `use_internal_dns` is set then will require `dhcp_set_id`. this will allow the VPC to use internal BB DNS

 - _subnets.tf_
    - __Public Subnets (DMZ)__

        Default CIDR `10.0.0.160/27, 10.0.0.192/28, 10.0.0.224/28`

        Public IP on Launch `true`

    - __Private Subnets__
        
        Default CIDR `10.0.0.160/27, 10.0.0.192/27, 10.0.0.224/27`

    - __RDS Subnets__
        
        Default CIDR `10.0.0.48/28, 10.0.0.64/24, 10.0.0.80/28`

        RDS Subnet group with all above subnets in group

    - __elasticache Subnet (Used for elasticache DB like things i.e. elasticache)__

        Default CIDR `10.0.0.48/28, 10.0.0.64/24, 10.0.0.80/28`

    - __elasticache Subnet Group__

 - _endpoints_gateways.tf_
    - __Internet Gateway__
    - __S3 VPC Endpoint__
    - __Nat Gateway EIP__
    - __Nat Gateway__

        Default enables one NAT across VPC

 - _routing.tf_
    - __Private routing table__

        Route to NAT Gateway for 0.0.0.0/0
        
        Route to S3 using service endpoint

        Associates Private Subnets

        Associates RDS Subnets

        Associates elasticache Subnets

    - __Public routing table__

        Route to Internet Gateway for 0.0.0.0/0
        
        Route to S3 using service endpoint

        Associates Public Subnets

 - _security_groups.tf_
    - __default Security group__

        Ensure it is tagged correctly

    - __SSH security Group__

        Creates security group with safe IPs and VPC IPs

 - _route53.tf_
    - __zone_association__

        Creates the association between the VPC and the hosted Zone


### Inputs
- `tags` - dictionary of tags that will be added to resources created by the module
- `name` - name to be used on all the resources created by the module
- `cidr` - the CIDR block for the VPC
- `instance_tenancy` - tenancy option for instances launched into the VPC
- `enable_dns_hostnames` - should be true if you want to use private DNS within the VPC
- `enable_dns_support` - should be true if you want to use private DNS within the VPC
- `public_subnets` - list of public subnet cidrs
- `map_public_ip_on_launch` - should be false if you do not want to auto-assign public IP on launch
- `public_subnet_tags` - dictionary of tags that will be added to public subnets created by the module
- `private_subnets` - list of private subnet cidrs
- `private_subnet_tags` - dictionary of tags that will be added to private subnets created by the module
- `rds_subnets` - list of private RDS subnet cidrs
- `rds_subnet_tags` - dictionary of tags that will be added to database subnets created by the module
- `elasticache_subnets` - list of private RDS subnet cidrs
- `elasticache_subnet_tags` - dictionary of tags that will be added to elasticcache subnets created by the module
- `enable_s3_endpoint` - should be true if you want to provision an S3 endpoint within the VPC
- `enable_nat_gateway` - should be true if you want to provision NAT Gateways
- `single_nat_gateway` - should be true if you want to provision a single shared NAT Gateway across all of your private networks
- `public_propagating_vgws` - list of VGWs the public route table should propagate
- `private_propagating_vgws` - list of VGWs the private route table should propagate
- `use_interal_dhcp` - If set to true will use the dhcp set given by var.dhcp_set_id
- `dhcp_set_id` - ID of DHCP Options
- `use_internal_dns` - Use the bb internal dns

### Outputs
- `vpc_id` - VPC ID
- `vpc_cidr_block` - CIDR Block of VPC
- `public_subnets`-  CIDR Block of public subnets
- `private_subnets`-  CIDR Block of private subnets
- `rds_subnets` - CIDR Block of rds subnets
- `rds_subnet_group_name` - Subnet group name
- `rds_subnet_group_id` - Subnet group ID 
- `rds_subnet_group_arn` - Subnet Group ARN
- `elasticache_subnet_group_name` - Subnet group name
- `elasticache_subnet_group_id` - Subnet group ID 
- `elasticache_subnet_group_arn` - Subnet Group ARN
- `elasticache_subnets` - CIDR Block of elasticache subnets
- `igw_id` - ID of internet gateway
- `nat_eips` - EIP's for NAT gateways
- `nat_eips_public_ips` - NAT gateways' public Elastic IPs
- `natgw_ids` - NAT Gateways IDs
- `public_route_table_ids` - ID of routing table for public Subnets
- `private_route_table_ids` - ID of routing table for private Subnets
- `ssh_sg_id` - ID of the ssh security group.
- `internal_dns_zone_id` - The ID of the internal DNS zone that the VPC is connected to.


### Usage

When sourcing this module, should use dot notation.

    module "aws_vpc" {
      source = "../../modules/baws_vpc"

      name = "${var.environment}-${var.role}"

      tags {
        "terraform"       = "true"
        "location"     = "aws"
        "environment"  = "${var.environment}"
        "owner"        = "${var.owner}"
        "role"         = "${var.role}"
        "service"      = "${var.service}"
      }
    }

If you want to supply different IP ranges you must do for all subnets

    module "aws_vpc" {
      source = "../../modules/aws_vpc"

      name = "${var.environment}-${var.role}"

      cidr            = "192.168.254.0/23"
      public_subnets  = ["192.168.254.0/28","192.168.254.16/28","192.168.254.32/28"]
      private_subnets = ["192.168.254.160/27", "192.168.254.192/27", "192.168.254.224/27"]
      rds_subnets     = ["192.168.254.48/28", "192.168.254.64/28", "192.168.254.80/28"]
      elasticache_subnets   = ["192.168.254.96/28", "192.168.254.112/28", "192.168.254.128/28"]

      tags {
        "terraform"       = "true"
        "location"     = "aws"
        "environment"  = "${var.environment}"
        "owner"        = "${var.owners}"
        "role"         = "${var.role}"
      }
    }
  

Then in the outputs file if you like all out puts copy below:

    ### aws_base_service Module outputs
    output "vpc_id" {
      value = "${module.aws_base_service.vpc_id}"
    }
    output vpc_cidr_block {
      value = "${module.aws_base_service.vpc_cidr_block}"
    }
    ##### Subnets #####
    output "public_subnets" {
      value = "${module.aws_base_service.public_subnets}"
    }

    output "private_subnets" {
      value = "${module.aws_base_service.private_subnets}"
    }

    output "rds_subnets" {
      value = "${module.aws_base_service.rds_subnets}"
    }

    output "rds_subnet_group_id" {
      value = "${module.aws_base_service.rds_subnet_group_id}"
    }

    output "rds_subnet_group_arn" {
      value = "${module.aws_base_service.rds_subnet_group_arn}"
    }

    output "elasticache_subnets" {
      value = "${module.aws_base_service.elasticache_subnets}"
    }

    ##### Endpoints and Gateways #####
    output "igw_id" {
      value = "${module.aws_base_service.igw_id}"
    }

    output "nat_eips" {
      value = "${module.aws_base_service.nat_eips}"
    }

    output "nat_eips_public_ips" {
      value = "${module.aws_base_service.nat_eips_public_ips}"
    }

    output "natgw_ids" {
      value = "${module.aws_base_service.natgw_ids}"
    }

    ##### Routing #####
    output "public_route_table_ids" {
      value = "${module.aws_base_service.public_route_table_ids}"
    }

    output "private_route_table_ids" {
      value = "${module.aws_base_service.private_route_table_ids}"
    }
