resource "aws_cloudwatch_metric_alarm" "cloudwatch_alarm" {
    alarm_name = "${var.caller}-${var.name}"
    alarm_description = "${var.description}"
    metric_name = "${var.metric}"
    comparison_operator = "${var.operator}"
    threshold = "${var.threshold}"
    datapoints_to_alarm = "${var.datapoints}"
    evaluation_periods = "${var.eval_pds}"
    statistic = "${var.stats}"
    period = "${var.period}"
    namespace = "${var.namespace}"
    dimensions = "${var.dimensions}"
    treat_missing_data = "${var.missdata}"
    alarm_actions = "${var.alarmx}"
    insufficient_data_actions = "${var.badatx}"
    ok_actions = "${var.okx}"
    actions_enabled = "${var.enablex}"
    /*tags = {
        Name = "${var.caller}-${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }*/

    count = "${local.farm}"
}
