variable "caller" {}
variable "envname" {
    default = []
}
variable "svc" {}
variable "name" {}
variable "connections" {
    default = []
}
variable "s3_python_lib_location" {}
variable "s3_tmp_dir" {}
variable "script_location" {}
variable "role_arn" {}
variable "s3_config_file_location" {}