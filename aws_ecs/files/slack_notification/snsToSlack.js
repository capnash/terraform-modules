var https = require('https');
var util = require('util');

exports.handler = function(event, context) {
    let channel = process.env.SLACK_CHANNEL
    let slack_path = process.env.SLACK_WEBHOOK_PATH

    console.log(JSON.stringify(event, null, 2));
    console.log('From SNS:', event.Records[0].Sns.Message);

    var postData = {
        "channel": channel,
        "username": "AWS SNS via Lamda",
        "text": "*" + event.Records[0].Sns.Subject + "*",
        "icon_emoji": ":aws_asg:"
    };

    var message_json = JSON.parse(event.Records[0].Sns.Message);
    var message_description = message_json.Description;
    var message_alarm = message_json.Details.InvokingAlarms[0].AlarmName;
    var message_region = message_json.Details.InvokingAlarms[0].Region;
    var message_trigger = message_json.Details.InvokingAlarms[0].Trigger.MetricName 
                        + " was " + message_json.Details.InvokingAlarms[0].Trigger.ComparisonOperator 
                        + " of " + message_json.Details.InvokingAlarms[0].Trigger.Threshold;

    var severity = "good";
  

    postData.attachments = [
        {
            "color": severity,
            "pretext": message_description,
            "author_name": message_region,
            "title": "Trigger: " + message_alarm,
            "text": message_trigger
        }
    ];

    var options = {
        method: 'POST',
        hostname: 'hooks.slack.com',
        port: 443,
        path: slack_path
    };

    var req = https.request(options, function(res) {
      res.setEncoding('utf8');
      res.on('data', function (chunk) {
        context.done(null);
      });
    });
    
    req.on('error', function(e) {
      console.log('problem with request: ' + e.message);
    });    

    req.write(util.format("%j", postData));
    req.end();
};