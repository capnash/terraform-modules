resource "aws_kinesis_firehose_delivery_stream" "kinesis_firehose" {
    name = "${upper(var.caller)}-${var.name}"
    destination = "${var.destination}"
    dynamic "kinesis_source_configuration" {
        for_each = [for key in var.kinesis_source: {
            map = merge(local.defaults.kinesis_source,key)
        }]
        content {
            kinesis_stream_arn = kinesis_source_configuration.value.map.kinesis_stream_arn
            role_arn = kinesis_source_configuration.value.map.role_arn
        }
    }
    dynamic "server_side_encryption" {
        for_each = [for key in var.server_side_encryption: {
            map = merge(local.defaults.server_side_encryption,key)
        }]
        content {
            enabled = server_side_encryption.value.map.enabled
        }
    }
    dynamic "s3_configuration" {
        for_each = [for key in var.s3_config: {
            map = merge(local.defaults.s3_config,key)
        }]
        content {
            role_arn = s3_configuration.value.map.role_arn
            bucket_arn = s3_configuration.value.map.bucket_arn
            prefix = s3_configuration.value.map.prefix
            buffer_size = s3_configuration.value.map.buffer_size
            buffer_interval = s3_configuration.value.map.buffer_interval
            compression_format = s3_configuration.value.map.compression_format
            kms_key_arn = s3_configuration.value.map.kms_key_arn
            dynamic "cloudwatch_logging_options" {
                for_each = [for i in s3_configuration.value.map.cloudwatch_logging_options: {
                    clog = merge(local.defaults.cloudwatch_logging,i)
                }]
                content {
                    enabled = cloudwatch_logging_options.value.clog.enabled
                    log_group_name = cloudwatch_logging_options.value.clog.log_group_name
                    log_stream_name = cloudwatch_logging_options.value.clog.log_stream_name
                }
            }
        }
    }
    dynamic "extended_s3_configuration" {
        for_each = [for key in var.extended_s3_config: {
            map = merge(local.defaults.s3_config,local.defaults.extended_s3_config,key)
        }]
        content {
            role_arn = extended_s3_configuration.value.map.role_arn
            bucket_arn = extended_s3_configuration.value.map.bucket_arn
            prefix = extended_s3_configuration.value.map.prefix
            buffer_size = extended_s3_configuration.value.map.buffer_size
            buffer_interval = extended_s3_configuration.value.map.buffer_interval
            compression_format = extended_s3_configuration.value.map.compression_format
            kms_key_arn = extended_s3_configuration.value.map.kms_key_arn
            dynamic "data_format_conversion_configuration" {
                for_each = [for n in extended_s3_configuration.value.map.data_format_conversion_configuration: {
                    datamorph = merge(local.defaults.data_format_conversion_configuration,n)
                }]
                content {
                    enabled = data_format_conversion_configuration.value.datamorph.enabled
                    dynamic "input_format_configuration" {
                        for_each = [for i in data_format_conversion_configuration.value.datamorph.input_format_configuration: {
                            inp = merge(local.defaults.input_format_configuration,i)
                        }]
                        content {
                            dynamic "deserializer" {
                                for_each = [for deser in input_format_configuration.value.inp.deserializer: {
                                    des = merge(local.defaults.deserializer,deser)
                                }]
                                content {
                                    dynamic "hive_json_ser_de" {
                                        for_each = [for hive in deserializer.value.des.hive_json_ser_de: {
                                            hson = merge(local.defaults.hive_json_ser_de,hive)
                                        }]
                                        content {
                                            timestamp_formats = hive_json_ser_de.value.hson.timestamp_formats
                                        }
                                    }
                                    dynamic "open_x_json_ser_de" {
                                        for_each = [for openx in deserializer.value.des.open_x_json_ser_de: {
                                            oson = merge(local.defaults.open_x_json_ser_de,openx)
                                        }]
                                        content {
                                            case_insensitive = open_x_json_ser_de.value.oson.case_insensitive
                                            column_to_json_key_mappings = open_x_json_ser_de.value.oson.column_to_json_key_mappings
                                            convert_dots_in_json_keys_to_underscores = open_x_json_ser_de.value.oson.convert_dots_in_json_keys_to_underscores
                                        }
                                    }
                                }
                            }
                        }
                    }
                    dynamic "output_format_configuration" {
                        for_each = [for o in data_format_conversion_configuration.value.datamorph.output_format_configuration: {
                            outp = merge(local.defaults.output_format_configuration,o)
                        }]
                        content {
                            dynamic "serializer" {
                                for_each = [for seri in output_format_configuration.value.outp.serializer: {
                                    ser = merge(local.defaults.deserializer,seri)
                                }]
                                content {
                                    dynamic "orc_ser_de" {
                                        for_each = [for orcser in serializer.value.ser.orc_ser_de: {
                                            orc = merge(local.defaults.orc_ser_de,orcser)
                                        }]
                                        content {
                                            block_size_bytes = orc_ser_de.value.orc.block_size_bytes
                                            bloom_filter_columns = orc_ser_de.value.orc.bloom_filter_columns
                                            bloom_filter_false_positive_probability = orc_ser_de.value.orc.bloom_filter_false_positive_probability
                                            compression = orc_ser_de.value.orc.compression
                                            dictionary_key_threshold = orc_ser_de.value.orc.dictionary_key_threshold
                                            enable_padding = orc_ser_de.value.orc.enable_padding
                                            format_version = orc_ser_de.value.orc.format_version
                                            padding_tolerance = orc_ser_de.value.orc.padding_tolerance
                                            row_index_stride = orc_ser_de.value.orc.row_index_stride
                                            stripe_size_bytes = orc_ser_de.value.orc.stripe_size_bytes
                                        }
                                    }
                                    dynamic "parquet_ser_de" {
                                        for_each = [for parqser in serializer.value.ser.parquet_ser_de: {
                                            par = merge(local.defaults.parquet_ser_de,parqser)
                                        }]
                                        content {
                                            block_size_bytes = parquet_ser_de.value.par.block_size_bytes
                                            compression = parquet_ser_de.value.par.compression
                                            enable_dictionary_compression = parquet_ser_de.value.par.enable_dictionary_compression
                                            max_padding_bytes = parquet_ser_de.value.par.max_padding_bytes
                                            page_size_bytes = parquet_ser_de.value.par.page_size_bytes
                                            writer_version = parquet_ser_de.value.par.writer_version
                                        }
                                    }
                                }
                            }
                        }
                    }
                    dynamic "schema_configuration" {
                        for_each = [for scheme in data_format_conversion_configuration.value.datamorph.schema_configuration: {
                            sc = merge(local.defaults.schema_configuration,scheme)
                        }]
                        content {
                            database_name = schema_configuration.value.sc.database_name
                            role_arn = schema_configuration.value.sc.role_arn
                            table_name = schema_configuration.value.sc.role_arn
                            catalog_id = schema_configuration.value.sc.catalog_id
                            region = schema_configuration.value.sc.region
                            version_id = schema_configuration.value.sc.version_id
                        }
                    }
                }
            }
            error_output_prefix = extended_s3_configuration.value.map.error_output_prefix
            dynamic "processing_configuration" {
                for_each = [for x in extended_s3_configuration.value.map.processing_configuration: {
                    procon = merge(local.defaults.process_conf,x)
                }]
                content {
                    enabled = processing_configuration.value.procon.enabled
                    dynamic "processors" {
                        for_each = [for p in processing_configuration.value.procon.processors: {
                            procs = merge(local.defaults.processors,p)
                        }]
                        content {
                            type = processors.value.procs.type
                            dynamic "parameters" {
                                for_each = [for d in processors.value.procs.parameters: {
                                    params = merge(local.defaults.process_params,d)
                                }]
                                content {
                                    parameter_name = parameters.value.params.parameter_name
                                    parameter_value = parameters.value.params.parameter_value
                                }
                            }
                        }
                    }
                }
            }
            s3_backup_mode = extended_s3_configuration.value.map.s3_backup_mode
            dynamic "s3_backup_configuration" {
                for_each = [for i in extended_s3_configuration.value.map.s3_backup_configuration: {
                    s3 = merge(local.defaults.s3_config,i)
                }]
                content {
                    role_arn = s3_backup_configuration.value.s3.role_arn
                    bucket_arn = s3_backup_configuration.value.s3.bucket_arn
                    prefix = s3_backup_configuration.value.s3.prefix
                    buffer_size = s3_backup_configuration.value.s3.buffer_size
                    buffer_interval = s3_backup_configuration.value.s3.buffer_interval
                    compression_format = s3_backup_configuration.value.s3.compression_format
                    kms_key_arn = s3_backup_configuration.value.s3.kms_key_arn
                    dynamic "cloudwatch_logging_options" {
                        for_each = [for x in s3_backup_configuration.value.s3.cloudwatch_logging_options: {
                            sclog = merge(local.defaults.cloudwatch_logging,x)
                        }]
                        content {
                            enabled = cloudwatch_logging_options.value.sclog.enabled
                            log_group_name = cloudwatch_logging_options.value.sclog.log_group_name
                            log_stream_name = cloudwatch_logging_options.value.sclog.log_stream_name
                        }
                    }
                }
            }
        }
    }
    dynamic "redshift_configuration" {
        for_each = [for key in var.redshift_config: {
            map = merge(local.defaults.redshift_config,key)
        }]
        content {
            cluster_jdbcurl = redshift_configuration.value.map.cluster_jdbcurl
            username = redshift_configuration.value.map.username
            password = redshift_configuration.value.map.password
            retry_duration = redshift_configuration.value.map.retry_duration
            role_arn = redshift_configuration.value.map.role_arn
            dynamic "s3_backup_configuration" {
                for_each = [for i in redshift_configuration.value.map.s3_backup_configuration: {
                    s3 = merge(local.defaults.s3_config,i)
                }]
                content {
                    role_arn = s3_backup_configuration.value.s3.role_arn
                    bucket_arn = s3_backup_configuration.value.s3.bucket_arn
                    prefix = s3_backup_configuration.value.s3.prefix
                    buffer_size = s3_backup_configuration.value.s3.buffer_size
                    buffer_interval = s3_backup_configuration.value.s3.buffer_interval
                    compression_format = s3_backup_configuration.value.s3.compression_format
                    kms_key_arn = s3_backup_configuration.value.s3.kms_key_arn
                    dynamic "cloudwatch_logging_options" {
                        for_each = [for x in s3_backup_configuration.value.s3.cloudwatch_logging_options: {
                            sclog = merge(local.defaults.cloudwatch_logging,x)
                        }]
                        content {
                            enabled = cloudwatch_logging_options.value.sclog.enabled
                            log_group_name = cloudwatch_logging_options.value.sclog.log_group_name
                            log_stream_name = cloudwatch_logging_options.value.sclog.log_stream_name
                        }
                    }
                }
            }
            data_table_name = redshift_configuration.value.map.data_table_name
            dynamic "cloudwatch_logging_options" {
                for_each = [for i in redshift_configuration.value.cloudwatch_logging_options: {
                    clog = merge(local.defaults.cloudwatch_logging,i)
                }]
                content {
                    enabled = cloudwatch_logging_options.value.clog.enabled
                    log_group_name = cloudwatch_logging_options.value.clog.log_group_name
                    log_stream_name = cloudwatch_logging_options.value.clog.log_stream_name
                }
            }
            dynamic "processing_configuration" {
                for_each = [for x in redshift_configuration.value.map.processing_configuration: {
                    procon = merge(local.defaults.process_conf,x)
                }]
                content {
                    enabled = processing_configuration.value.procon.enabled
                    dynamic "processors" {
                        for_each = [for p in processing_configuration.value.procon.processors: {
                            procs = merge(local.defaults.processors,p)
                        }]
                        content {
                            type = processors.value.procs.type
                            dynamic "parameters" {
                                for_each = [for d in processors.value.procs.parameters: {
                                    params = merge(local.defaults.process_params,d)
                                }]
                                content {
                                    parameter_name = parameters.value.params.parameter_name
                                    parameter_value = parameters.value.params.parameter_value
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    dynamic "elasticsearch_configuration" {
        for_each = [for key in var.es_config: {
            map = merge(local.defaults.es_config,key)
        }]
        content {
            buffering_interval = elasticsearch_configuration.value.map.buffering_interval
            buffering_size = elasticsearch_configuration.value.map.buffering_size
            domain_arn = elasticsearch_configuration.value.map.domain_arn
            index_name = elasticsearch_configuration.value.map.index_name
            index_rotation_period = elasticsearch_configuration.value.map.index_rotation_period
            retry_duration = elasticsearch_configuration.value.map.retry_duration
            role_arn = elasticsearch_configuration.value.map.role_arn
            s3_backup_mode = elasticsearch_configuration.value.map.s3_backup_mode
            type_name = elasticsearch_configuration.value.map.type_name
            dynamic "cloudwatch_logging_options" {
                for_each = [for i in elasticsearch_configuration.value.map.cloudwatch_logging_options: {
                    clog = merge(local.defaults.cloudwatch_logging,i)
                }]
                content {
                    enabled = cloudwatch_logging_options.value.clog.enabled
                    log_group_name = cloudwatch_logging_options.value.clog.log_group_name
                    log_stream_name = cloudwatch_logging_options.value.clog.log_stream_name
                }
            }
            dynamic "processing_configuration" {
                for_each = [for x in elasticsearch_configuration.value.map.processing_configuration: {
                    procon = merge(local.defaults.process_conf,x)
                }]
                content {
                    enabled = processing_configuration.value.procon.enabled
                    dynamic "processors" {
                        for_each = [for p in processing_configuration.value.procon.processors: {
                            procs = merge(local.defaults.processors,p)
                        }]
                        content {
                            type = processors.value.procs.type
                            dynamic "parameters" {
                                for_each = [for d in processors.value.procs.parameters: {
                                    params = merge(local.defaults.process_params,d)
                                }]
                                content {
                                    parameter_name = parameters.value.params.parameter_name
                                    parameter_value = parameters.value.params.parameter_value
                                }
                            }
                        }
                    }
                }
            }
            dynamic "vpc_config" {
                for_each = [for x in elasticsearch_configuration.value.map.vpc_config: {
                    vpc = merge(local.defaults.vpc_config,x)
                }]
                content {
                    role_arn = vpc_config.value.vpc.role_arn
                    security_group_ids = vpc_config.value.vpc.security_group_ids
                    subnet_ids = vpc_config.value.vpc.subnet_ids
                    vpc_id = vpc_config.value.vpc.vpc_id
                }
            }
        }
    }
    dynamic "splunk_configuration" {
        for_each = [for key in var.splunk_config: {
            map = merge(local.defaults.splunk_config)
        }]
        content {
            hec_acknowledgment_timeout = splunk_configuration.value.map.hec_acknowledgment_timeout
            hec_endpoint = splunk_configuration.value.map.hec_endpoint
            hec_endpoint_type = splunk_configuration.value.map.hec_endpoint_type
            hec_token = splunk_configuration.value.map.hec_token
            s3_backup_mode = splunk_configuration.value.map.s3_backup_mode
            retry_duration = splunk_configuration.value.map.retry_duration
            dynamic "cloudwatch_logging_options" {
                for_each = [for i in splunk_configuration.value.cloudwatch_logging_options: {
                    clog = merge(local.defaults.cloudwatch_logging,i)
                }]
                content {
                    enabled = cloudwatch_logging_options.value.clog.enabled
                    log_group_name = cloudwatch_logging_options.value.clog.log_group_name
                    log_stream_name = cloudwatch_logging_options.value.clog.log_stream_name
                }
            }
            dynamic "processing_configuration" {
                for_each = [for x in splunk_configuration.value.map.processing_configuration: {
                    procon = merge(local.defaults.process_conf,x)
                }]
                content {
                    enabled = processing_configuration.value.procon.enabled
                    dynamic "processors" {
                        for_each = [for p in processing_configuration.value.procon.processors: {
                            procs = merge(local.defaults.processors,p)
                        }]
                        content {
                            type = processors.value.procs.type
                            dynamic "parameters" {
                                for_each = [for d in processors.value.procs.parameters: {
                                    params = merge(local.defaults.process_params,d)
                                }]
                                content {
                                    parameter_name = parameters.value.params.parameter_name
                                    parameter_value = parameters.value.params.parameter_value
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
