resource "aws_elasticsearch_domain_policy" "elasticsearch_domain_policy" {
    domain_name = "${var.es_domain}"
    access_policies = "${var.policies}"

    count = "${local.farm}"
}
