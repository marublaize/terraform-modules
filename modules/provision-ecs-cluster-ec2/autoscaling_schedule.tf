resource "aws_autoscaling_schedule" "schedule_stop" {
  count                  = var.env == "dev" || var.env == "hml" || var.env == "ppr" ? 1:0
  scheduled_action_name  = "${aws_ecs_cluster.main.name}-ScheduledStop"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  recurrence             = "00 22 * * *"
  autoscaling_group_name = aws_autoscaling_group.main.name
}

resource "aws_autoscaling_schedule" "schedule_start" {
  count                  = var.env == "dev" || var.env == "hml" || var.env == "ppr" ? 1:0
  scheduled_action_name  = "${aws_ecs_cluster.main.name}-ScheduledStart"
  min_size               = "${var.min_cluster_size}"
  max_size               = "${var.max_cluster_size}"
  desired_capacity       = "${var.min_cluster_size}"
  recurrence             = "00 10 * * MON-FRI"
  autoscaling_group_name = aws_autoscaling_group.main.name
}
