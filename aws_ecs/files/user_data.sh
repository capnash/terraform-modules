#!/bin/bash

# Timezone
ln -fs ${time_zone_path} /etc/localtime

#Using script from http://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_cloudwatch_logs.html
# Install awslogs and the jq JSON parser
yum install -y awslogs jq aws-cli
yum -y install https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm

# ECS config
${ecs_config}
cat <<EOT >> /etc/ecs/ecs.config
ECS_CLUSTER=${cluster_name}
ECS_AVAILABLE_LOGGING_DRIVERS=${ecs_logging}
EOT

# Inject the CloudWatch Logs configuration file contents
cat <<EOT > /etc/awslogs/awslogs.conf
[general]
state_file = /var/lib/awslogs/agent-state
 
[/var/log/dmesg]
file = /var/log/dmesg
log_group_name = ${cloudwatch_prefix}/var/log/dmesg
log_stream_name = ${cluster_name}/{container_instance_id}

[/var/log/messages]
file = /var/log/messages
log_group_name = ${cloudwatch_prefix}/var/log/messages
log_stream_name = ${cluster_name}/{container_instance_id}
datetime_format = %b %d %H:%M:%S

[/var/log/docker]
file = /var/log/docker
log_group_name = ${cloudwatch_prefix}/var/log/docker
log_stream_name = ${cluster_name}/{container_instance_id}
datetime_format = %Y-%m-%dT%H:%M:%S.%f

[/var/log/ecs/ecs-init.log]
file = /var/log/ecs/ecs-init.log.*
log_group_name = ${cloudwatch_prefix}/var/log/ecs/ecs-init.log
log_stream_name = ${cluster_name}/{container_instance_id}
datetime_format = %Y-%m-%dT%H:%M:%SZ

[/var/log/ecs/ecs-agent.log]
file = /var/log/ecs/ecs-agent.log.*
log_group_name = ${cloudwatch_prefix}/var/log/ecs/ecs-agent.log
log_stream_name = ${cluster_name}/{container_instance_id}
datetime_format = %Y-%m-%dT%H:%M:%SZ

[/var/log/ecs/audit.log]
file = /var/log/ecs/audit.log.*
log_group_name = ${cloudwatch_prefix}/var/log/ecs/audit.log
log_stream_name = ${cluster_name}/{container_instance_id}
datetime_format = %Y-%m-%dT%H:%M:%SZ
EOT

# Set the region to send CloudWatch Logs data to (the region where the container instance is located)
region=$(curl 169.254.169.254/latest/meta-data/placement/availability-zone | sed s'/.$//')
sed -i -e "s/region = us-east-1/region = $region/g" /etc/awslogs/awscli.conf

# Set the ip address of the node 
container_instance_id=$(curl 169.254.169.254/latest/meta-data/local-ipv4)
sed -i -e "s/{container_instance_id}/$container_instance_id/g" /etc/awslogs/awslogs.conf

systemctl restart awslogsd
systemctl enable awslogsd

#Custom userdata script code
${custom_userdata}

echo "Done"
