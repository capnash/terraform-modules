resource "aws_glue_connection" "glue_redshift_vpc_connection" {
    name = "${var.caller}_${var.name}"

    connection_properties = {
        JDBC_CONNECTION_URL = var.connection_url
        PASSWORD = var.password
        USERNAME = var.username
    }

    physical_connection_requirements {
        availability_zone = var.availability_zone
        security_group_id_list = var.security_group_id_list
        subnet_id = var.subnet_id
    }
}