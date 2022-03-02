resource "aws_cloudwatch_log_group" "main" {
  name              = "${aws_ecs_cluster.main.name}-logs"
  retention_in_days = "${var.log_retention}"
}