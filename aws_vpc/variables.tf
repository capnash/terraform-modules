# ##### TAGS #####
# variable "tags" {
#   description = "A map of tags to add to all resources"
#   default     = {}
# }

# variable "name" {
#   description = "Name to be used on all the resources as identifier"
#   default     = ""
# }

# ##### Network #####
# variable "public_subnet_tags" {
#   description = "Additional tags for the public subnets"
#   default     = {}
# }

# variable "private_subnet_tags" {
#   description = "Additional tags for the private subnets"
#   default     = {}
# }

# variable "rds_subnet_tags" {
#   description = "Additional tags for the rds subnets"
#   default     = {}
# }

# variable "elasticache_subnet_tags" {
#   description = "Additional tags for the elasticache subnets"
#   default     = {}
# }

# variable "ssh_safe_ips" {
#   description = "IP consider safe for ssh access"
#   type        = "map"
# }

# variable "vpc_cidrs" {
#   description = "all the other vpc ip cidr"
#   type        = "list"
#   default     = [""]
# }

# ##### VPC #####
variable "cidr" {
  description = "The CIDR block for the VPC"
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = true
}

# variable "use_internal_dhcp" {
#   description = "If set to true will use the dhcp set given by var.dhcp_set_id"
# }

# variable "dhcp_set_id" {
#   description = "ID of DHCP Options"
#   default     = ""
# }

# variable "use_internal_dns" {
#   type        = "string"
#   description = "do you want to use the bb internal DNS"
#   default     = true
# }

# variable "internal_zone_id" {
#   type        = "string"
#   description = "The private route53 zone id to use for dns"
#   default     = ""
# }

# ##### Subnet #####
# variable "public_subnets_cidr" {
#   description = "CIDR for public subets"
#   type        = "string"
#   default     = "0.0.0.0/0"
# }
# variable "private_subnets_cidr" {
#   description = "cidr for private subnets"
#   type        = "string"
#   default     = "0.0.0.0/0"
# }

# variable "rds_subnets_cidr" {
#   description = "cidr for rds subnets"
#   type        = "string"
#   default     = "0.0.0.0/0"
# }

# variable "elasticache_subnets_cidr" {
#   description = "cidr for elastic cache subnets"
#   type        = "string"
#   default     = "0.0.0.0/0"
# }

# variable "map_public_ip_on_launch" {
#   description = "should be false if you do not want to auto-assign public IP on launch"
#   default     = true
# }

# # keep these ones for compatibilty
# variable "public_subnets" {
#   description = "A list of public subnets inside the VPC."
#   default     = []
# }

# variable "private_subnets" {
#   description = "A list of private subnets inside the VPC."
#   default     = []
# }

# variable "rds_subnets" {
#   type        = "list"
#   description = "A list of cidr for database subnets inside the VPC."
#   default     = []
# }

# variable "elasticache_subnets" {
#   type        = "list"
#   description = "A list of cidr for elasticache resources subnets inside the VPC"
#   default     = []
# }


# ##### Endpoints and Gateways #####
# variable "enable_s3_endpoint" {
#   description = "should be true if you want to provision an S3 endpoint to the VPC"
#   default     = true
# }

# variable "enable_nat_gateway" {
#   description = "should be true if you want to provision NAT Gateways for each of your private networks"
#   default     = true
# }

# variable "single_nat_gateway" {
#   description = "should be true if you want to provision a single shared NAT Gateway across all of your private networks"
#   default     = true
# }

# ##### Routing #####
# variable "public_propagating_vgws" {
#   description = "A list of VGWs the public route table should propagate."
#   default     = []
# }

# variable "private_propagating_vgws" {
#   description = "A list of VGWs the private route table should propagate."
#   default     = []
# }
