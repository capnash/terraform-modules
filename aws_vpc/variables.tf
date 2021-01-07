# ##### TAGS #####
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

# ##### Network #####
variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  type        = map
  default     = {}
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  type        = map
  default     = {}
}

variable "rds_subnet_tags" {
  description = "Additional tags for the rds subnets"
  type        = map
  default     = {}
}

variable "elasticache_subnet_tags" {
  description = "Additional tags for the elasticache subnets"
  type        = map
  default     = {}
}

variable "ssh_safe_ips" {
  description = "IP consider safe for ssh access"
  type        = map
}

# ##### VPC #####
variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  type        = string
  default     = true
}

variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  type        = string
  default     = true
}

variable "use_internal_dhcp" {
  description = "If set to true will use the dhcp set given by var.dhcp_set_id"
  type        = string
}

variable "dhcp_set_id" {
  description = "ID of DHCP Options"
  type        = string
  default     = ""
}

##### Subnet #####
variable "logical_subnets" {
  description = "This represents the 'newbits' in the cidrsubnet function that calculates the subnet sizes.  Default is good for when you only have 3 az's"
  type        = string
  default     = 2
}
variable "public_subnets_cidr" {
  description = "CIDR for public subets"
  type        = string
}
variable "private_subnets_cidr" {
  description = "cidr for private subnets"
  type        = string
}

variable "rds_subnets_cidr" {
  description = "cidr for rds subnets"
  type        = string
}

variable "elasticache_subnets_cidr" {
  description = "cidr for elastic cache subnets"
  type        = string
}

variable "map_public_ip_on_launch" {
  description = "should be false if you do not want to auto-assign public IP on launch"
  default     = true
}

##### Endpoints and Gateways #####
variable "enable_nat_gateway" {
  description = "should be true if you want to provision NAT Gateways for each of your private networks"
  type        = string
  default     = true
}

variable "single_nat_gateway" {
  description = "should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = string
  default     = true
}

