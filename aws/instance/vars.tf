variable "caller" {}

variable "envname" {
    default = []
}

variable "scale" {
    default = 1
}

variable "name" {}

variable "description" {}

variable "svc" {
    default = "Created by Terraform: No service entered"
}

variable "image" {}

variable "a_z" {
    default = "us-east-1a"
}

variable "group" {
    default = ""
}

variable "tenancy" {
    default = "default"
}

variable "ebs" {
    default = "true"
}

variable "protected" {
    default = "false"
}

variable "shutdown" {
    default = "stop"
}

variable "size" {
    default = "t2.micro"
}

variable "key" {
    default = ""
}

variable "passwd" {
    default = "false"
}

variable "monitor" {
    default = "true"
}

variable "sec_groups" {
    default = []
}

variable "subnet" {

}

variable "ip" {
    default = null
}

variable "dest_check" {
    default = "true"
}

variable "config" {
    default = ""
}

variable "role" {
    default = null
}

variable "volume_type" {
    default = "gp2"
}

variable "volume_size" {
    default = 32
}

variable "iops" {
    default = null
}

variable "volume_delete" {
    default = "true"
}

locals {
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${var.scale * local.enabled}"
}
