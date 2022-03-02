resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = var.service_name
  retention_in_days = 3
}

# Define the Assume Role IAM Policy Document for the ECS Service Scheduler IAM Role
data "aws_iam_policy_document" "ecs_task" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# This template_file defines the Docker containers we want to run in our ECS Task
data "template_file" "ecs_task_definition" {
  template = file("${path.module}/container-definition/container-definition.json")

  vars = {
    aws_region = var.aws_region
    container_name = var.service_name
    service_name = var.service_name
    image = var.image
    version = var.image_version
    cloudwatch_log_group_name = var.service_name
    cpu = var.cpu
    memory = var.memory
    container_port = var.container_port
  }
}

# Create the actual task definition by passing it the container definition from above
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                    = var.service_name
  container_definitions     = data.template_file.ecs_task_definition.rendered
  network_mode              = "awsvpc"
  cpu                       = var.cpu
  memory                    = var.memory
  requires_compatibilities  = ["FARGATE", "EC2"]
  task_role_arn             = aws_iam_role.ecs_task_role.arn
  execution_role_arn        = aws_iam_role.ecs_task_execution_role.arn
}

# Create the ECS service
resource "aws_ecs_service" "ecs_service" {
  name                                = var.service_name
  cluster                             = var.ecs_cluster
  task_definition                     = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count                       = var.desired_number_of_tasks
  deployment_maximum_percent          = var.deployment_maximum_percent
  deployment_minimum_healthy_percent  = var.deployment_minimum_healthy_percent
  health_check_grace_period_seconds   = var.health_check_grace_period_seconds
  launch_type                         = "FARGATE"
  platform_version                    = "LATEST"
  depends_on                          = [aws_lb_target_group.target_group]

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = var.service_name
    container_port   = var.container_port
  }

  network_configuration {
    subnets             = var.private_subnet_ids
    security_groups     = [aws_security_group.ecs_service_security_group.id]
    assign_public_ip    = var.assign_public_ip
  }
}

resource "aws_lb_target_group" "target_group" {
  name                  = var.service_name
  port                  = var.container_port
  protocol              = var.alb_target_group_protocol
  target_type           = "ip"
  vpc_id                = var.vpc_id
  deregistration_delay  = var.alb_target_group_deregistration_delay

  health_check {
    enabled             = true
    interval            = var.health_check_interval
    path                = var.health_check_path
    port                = var.container_port
    protocol            = var.health_check_protocol
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    matcher             = var.health_check_matcher
  }
}
