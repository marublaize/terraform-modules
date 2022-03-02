// ECS Scaling Policy
resource "aws_autoscaling_policy" "scale_up_policy" {
  name                   = "${aws_ecs_cluster.main.name}-ScaleUpPolicy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 120
  autoscaling_group_name = "${aws_autoscaling_group.main.name}"
}

resource "aws_autoscaling_policy" "scale_down_policy" {
  name                   = "${aws_ecs_cluster.main.name}-ScaleDownPolicy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.main.name}"
}
