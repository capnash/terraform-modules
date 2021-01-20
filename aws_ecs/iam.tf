resource "aws_iam_instance_profile" "profile" {
  name  = "${var.environment}-aws-ecs-instance-profile"
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name = "${var.environment}-aws-ecs-role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_policy_attach" {
    role       = aws_iam_role.role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecs_ssm_policy_attach" {
    role       = aws_iam_role.role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleForSSM"
}

resource "aws_iam_role_policy_attachment" "ecs_ec2_cloudwatch_role" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_role" "ecs_service_role" {
  name  = var.ecs_service_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
   
resource "aws_iam_role_policy_attachment" "ecs_service_role" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
  role       = aws_iam_role.ecs_service_role.name
}
  
resource "aws_iam_policy" "sqs_policy" {
  name        = "${var.environment}-aws-ecs-sqs-policy"
  description = "Policy to access SQS"
  
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject",
        "sqs:DeleteMessage",
        "sqs:ListQueues",
        "sqs:GetQueueUrl",
        "sqs:ListDeadLetterSourceQueues",
        "sqs:ChangeMessageVisibility",
        "sqs:DeleteMessageBatch",
        "sqs:SendMessageBatch",
        "sqs:ReceiveMessage",
        "sqs:SendMessage",
        "sqs:GetQueueAttributes",
        "sqs:ListQueueTags",
        "sqs:ChangeMessageVisibilityBatch",
        "sqs:ListQueues"
      ],
      "Resource": "arn:aws:sqs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
  }

resource "aws_iam_role_policy_attachment" "sqs_access_role_attachment" {
    role       = aws_iam_role.role.name
    policy_arn = aws_iam_policy.sqs_policy.arn
}

resource "aws_iam_role" "notifications_role" {
  name = "${var.environment}-aws-ecs_ecs_notifications_role"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["autoscaling.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "notifications_role_policy" {
  role       = aws_iam_role.notifications_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AutoScalingNotificationAccessRole"
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "${var.environment}-aws-ecs_ecs_lambda_exe"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["lambda.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_execution_role_notifications_policy_attach" {
  role       = aws_iam_role.lambda_execution_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AutoScalingNotificationAccessRole"
}

resource "aws_iam_policy" "lambda_execution_role_policy" {
  name        = "${var.environment}-aws-ecs-lambda-execution-policy"
  path        = "/"
  description = ""

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "autoscaling:CompleteLifecycleAction",
        "ec2:DescribeHosts",
        "ec2:DescribeInstanceAttribute",
        "ec2:DescribeInstanceStatus",
        "ec2:DescribeInstances",
        "ecs:DescribeContainerInstances",
        "ecs:DescribeTasks",
        "ecs:ListContainerInstances",
        "ecs:ListTasks",
        "ecs:SubmitContainerStateChange",
        "ecs:SubmitTaskStateChange",
        "ecs:UpdateContainerInstancesState",
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "sns:ListSubscriptions",
        "sns:Publish"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "lambda_execution_policy_attach" {
  role       = aws_iam_role.lambda_execution_role.id
  policy_arn = aws_iam_policy.lambda_execution_role_policy.arn
}

resource "aws_iam_role" "ecs_autoscale_role" {
  name = "${var.environment}-aws-ecs_autoscale"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["application-autoscaling.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_autoscale_policy_attach" {
  role       = aws_iam_role.ecs_autoscale_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}
      
resource "aws_iam_role" "ecs_execution_role" {
  name = "${var.environment}-aws-ecs_execution"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ecs-tasks.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy_attach" {
  role       = aws_iam_role.ecs_execution_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
      
resource "aws_iam_role_policy_attachment" "ecs_execution_policy_attach2" {
  role       = aws_iam_role.ecs_execution_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}

#############
## Outputs ##
#############
output "iam_instance_profile_ecs_id" {
  value = "${aws_iam_instance_profile.profile.id}"
}

output "iam_instance_profile_ecs_name" {
  value = "${aws_iam_instance_profile.profile.name}"
}

output "am_instance_profile_ecs_arn" {
  value = "${aws_iam_instance_profile.profile.arn}"
}

output "iam_role_ecs_name" {
  value = "${aws_iam_role.role.name}"
}

output "iam_role_ecs_arn" {
  value = "${aws_iam_role.role.arn}"
}

output "iam_role_ecs_service_role_name" {
  value = "${aws_iam_role.ecs_service_role.name}"
}

output "iam_role_ecs_service_role_arn" {
  value = "${aws_iam_role.ecs_service_role.arn}"
}

output "iam_policy_sqs_policy_arn" {
  value = aws_iam_policy.sqs_policy.arn
}

output "iam_policy_sqs_policy_id" {
  value = aws_iam_policy.sqs_policy.id
}

output "iam_role_notifications_role_name" {
  value = "${aws_iam_role.notifications_role.name}"
}

output "iam_role_notifications_role_arn" {
  value = "${aws_iam_role.notifications_role.arn}"
}

output "iam_role_lambda_execution_role_name" {
  value = "${aws_iam_role.lambda_execution_role.name}"
}

output "iam_role_lambda_execution_role_arn" {
  value = "${aws_iam_role.lambda_execution_role.arn}"
}

output "iam_policy_lambda_execution_policy_arn" {
  value = aws_iam_policy.lambda_execution_role_policy.arn
}

output "iam_policy_lambda_execution_policy_id" {
  value = aws_iam_policy.lambda_execution_role_policy.id
}

output "iam_role_ecs_autoscale_role_name" {
  value = "${aws_iam_role.ecs_autoscale_role.name}"
}

output "iam_role_ecs_autoscale_role_arn" {
  value = "${aws_iam_role.ecs_autoscale_role.arn}"
}

output "iam_role_ecs_execution_role_name" {
  value = "${aws_iam_role.ecs_execution_role.name}"
}

output "iam_role_ecs_execution_role_arn" {
  value = "${aws_iam_role.ecs_execution_role.arn}"
}
