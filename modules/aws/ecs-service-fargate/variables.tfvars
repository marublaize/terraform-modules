aws_region = "us-east-1"
service_name = "nginx"
ecs_cluster = "my-cluster-stage"

# Docker image configuration
image = nginx
image_version = latest
container_port = 80

# Runtime properties of this ECS Service in the ECS Cluster
cpu = 512
memory = 1024
desired_number_of_tasks = 1
allow_inbound_from_cidr_blocks = list

# VPC information
vpc_id = # string
private_subnet_ids = # list
public_subnet_ids = # list

# ALB options
ssl_cert_arn = # string
health_check_grace_period_seconds = 15
alb_target_group_protocol = HTTP
alb_target_group_deregistration_delay = 15

# Deployment Options
deployment_maximum_percent = 200
deployment_minimum_healthy_percent = 100

# Health check options
health_check_interval = 30
health_check_protocol = HTTP
health_check_timeout = 5
health_check_healthy_threshold = 5
health_check_unhealthy_threshold = 2
health_check_matcher = 200
