variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {}

variable "destination" {}

variable "kinesis_source" {
    default = []
}

variable "server_side_encryption" {
    default = []
}

variable "s3_config" {
    default = []
}

variable "extended_s3_config" {
    default = []
}

variable "redshift_config" {
    default = []
}

variable "es_config" {
    default = []
}

variable "splunk_config" {
    default = []
}

locals {
    defaults = {
        kinesis_source = {
            kinesis_stream_arn = ""
            role_arn = ""
        }
        server_side_encryption = {
            enabled = true
        }
        s3_config = {
            role_arn = ""
            bucket_arn = ""
            prefix = null
            buffer_size = null
            buffer_interval = null
            compression_format = "GZIP"
            kms_key_arn = null
            cloudwatch_logging_options = []
        }
        extended_s3_config = {
            data_format_conversion_configuration = null
            error_output_prefix = null
            processing_configuration = []
            s3_backup_mode = null
            s3_backup_configuration = []
        }
        data_format_conversion_configuration = {
            enabled = null
            input_format_configuration = []
            output_format_configuration = []
            schema_configuration = []
        }
        input_format_configuration = {
            deserializer = []
        }
        deserializer = {
            hive_json_ser_de = []
            open_x_json_ser_de = []
        }
        hive_json_ser_de = {
            timestamp_formats = []
        }
        open_x_json_ser_de = {
            case_insensitive = null
            column_to_json_key_mappings = null
            convert_dots_in_json_keys_to_underscores = null
        }
        output_format_configuration = {
            serializer = []
        }
        serializer = {
            orc_ser_de = []
            parquet_ser_de = []
        }
        orc_ser_de = {
            block_size_bytes = null
            bloom_filter_columns = null
            bloom_filter_false_positive_probability = null
            compression = null
            dictionary_key_threshold = null
            enable_padding = null
            format_version = null
            padding_tolerance = null
            row_index_stride = null
            stripe_size_bytes = null
        }
        parquet_ser_de = {
            block_size_bytes = null
            compression = null
            enable_dictionary_compression = null
            max_padding_bytes = null
            page_size_bytes = null
            writer_version = null
        }
        schema_configuration = {
            database_name = ""
            role_arn = ""
            table_name = ""
            catalog_id = null
            region = null
            version_id = null
        }
        redshift_config = {
            cluster_jdbcurl = ""
            username = ""
            password = ""
            retry_duration = null
            role_arn = ""
            s3_backup_mode = null
            s3_backup_configuration = []
            data_table_name = ""
            copy_options = null
            data_table_columns = null
            cloudwatch_logging_options = []
            processing_configuration = []
        }
        es_config = {
            buffering_interval = null
            buffering_size = null
            domain_arn = ""
            index_name = ""
            index_rotation_period = null
            retry_duration = null
            role_arn = ""
            s3_backup_mode = null
            type_name = null
            cloudwatch_logging_options = []
            processing_configuration = []
            vpc_config = []
        }
        splunk_config = {
            hec_acknowledgment_timeout = null
            hec_endpoint = ""
            hec_endpoint_type = null
            hec_token = ""
            s3_backup_mode = null
            retry_duration = null
            cloudwatch_logging_options = []
            processing_configuration = []
        }
        cloudwatch_logging = {
            enabled = null
            log_group_name = null
            log_stream_name = null
        }
        vpc_config = {
            role_arn = ""
            security_group_ids = []
            subnet_ids = []
            vpc_id = null
        }
        process_conf = {
            enabled = null
            processors = []
        }
        processors = {
            type = ""
            parameters = []
        }
        process_params = {
            parameter_name = ""
            parameter_value = ""
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
