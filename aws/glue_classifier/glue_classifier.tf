resource "aws_glue_classifier" "csv_glue_classifier" {
    name = "${upper(var.caller)}-${var.name}"
    
    csv_classifier {
        allow_single_column = false
        contains_header = var.contains_header
        delimiter = var.delimiter
        disable_value_trimming = false
        quote_symbol = var.quote_symbol
    }
}