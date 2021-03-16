variable "caller" {}
variable "envname" {
    default = []
}
variable "svc" {}
variable "name" {}

variable "contains_header" {
    description = "Wether the header is included on the file or not"
    default = "PRESENT"
}

variable "delimiter" {
    description = "CSV File delimiter"
    default = ","
}

variable "quote_symbol" {
    description = "Symbol used to identify quotes"
    default = "\""
}