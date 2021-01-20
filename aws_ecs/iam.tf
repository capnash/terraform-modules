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

resource "aws_iam_role_policy_attachment" "ecs-policy-attach" {
    role       = aws_iam_role.role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecs-SSMpolicy-attach" {
    role       = aws_iam_role.role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleForSSM"
}

resource "aws_iam_role_policy_attachment" "ecs_ec2_cloudwatch_role" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_role" "ecsServiceRole" {
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
   
resource "aws_iam_role_policy_attachment" "ecsServiceRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
  role       = aws_iam_role.ecsServiceRole.name
}
  
resource "aws_iam_policy" "SQS_policy" {
  name        = "${var.environment}-aws-ecs-SQSpolicy"
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
    policy_arn = aws_iam_policy.SQS_policy.arn
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
output "ecs_instance_profile_id" {
  value = "${aws_iam_instance_profile.profile.id}"
}

output "ecs_instance_profile_name" {
  value = "${aws_iam_instance_profile.profile.name}"
}

output "ecs_instance_profile_arn" {
  value = "${aws_iam_instance_profile.profile.arn}"
}

output "ecs_role_name" {
  value = "${aws_iam_role.role.name}"
}

output "ecs_role_arn" {
  value = "${aws_iam_role.role.arn}"
}

output "ecs_execution_role_name" {
  value = "${aws_iam_role.ecs_execution_role.name}"
}

output "ecs_execution_role_arn" {
  value = "${aws_iam_role.ecs_execution_role.arn}"
}

output "ecs_autoscale_role_name" {
  value = "${aws_iam_role.ecs_autoscale_role.name}"
}

output "ecs_autoscale_role_arn" {
  value = "${aws_iam_role.ecs_autoscale_role.arn}"
}

output "ecsServiceRole_name" {
  value = "${aws_iam_role.ecsServiceRole.name}"
}

output "ecsServiceRole_arn" {
  value = "${aws_iam_role.ecsServiceRole.arn}"
}

output "notifications_role_name" {
  value = "${aws_iam_role.notifications_role.name}"
}

output "notifications_role_arn" {
  value = "${aws_iam_role.notifications_role.arn}"
}

output "lambda_execution_role_name" {
  value = "${aws_iam_role.lambda_execution_role.name}"
}

output "lambda_execution_role_arn" {
  value = "${aws_iam_role.lambda_execution_role.arn}"
}