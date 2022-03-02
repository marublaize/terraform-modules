resource "aws_cloudwatch_metric_alarm" "cpu_alarm_up" {
    alarm_name          = "${aws_ecs_cluster.main.name}-CpuAlarmUp"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods  = "2"
    metric_name         = "CPUReservation"
    namespace           = "AWS/ECS"
    period              = "60"
    statistic           = "Average"
    threshold           = "70"

    dimensions = {
        ClusterName = "${aws_ecs_cluster.main.name}"
    }

    alarm_description = "This metric monitor EC2 instance CPU utilization"
    actions_enabled = true
    alarm_actions     = ["${aws_autoscaling_policy.scale_up_policy.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm_down" {
    alarm_name          = "${aws_ecs_cluster.main.name}-CpuAlarmDown"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods  = "5"
    metric_name         = "CPUReservation"
    namespace           = "AWS/ECS"
    period              = "60"
    statistic           = "Average"
    threshold           = "30"

    dimensions = {
        ClusterName = "${aws_ecs_cluster.main.name}"
    }

    alarm_description = "This metric monitor EC2 instance CPU utilization"
    actions_enabled = true
    alarm_actions     = ["${aws_autoscaling_policy.scale_down_policy.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "memory_alarm_up" {
    alarm_name          = "${aws_ecs_cluster.main.name}-MemoryAlarmUp"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods  = "2"
    metric_name         = "MemoryReservation"
    namespace           = "AWS/ECS"
    period              = "60"
    statistic           = "Average"
    threshold           = "70"

    dimensions = {
        ClusterName = "${aws_ecs_cluster.main.name}"
    }

    alarm_description = "This metric monitor EC2 instance CPU utilization"
    actions_enabled = true
    alarm_actions     = ["${aws_autoscaling_policy.scale_up_policy.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "memory_alarm_down" {
    alarm_name          = "${aws_ecs_cluster.main.name}-MemoryAlarmDown"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods  = "5"
    metric_name         = "MemoryReservation"
    namespace           = "AWS/ECS"
    period              = "60"
    statistic           = "Average"
    threshold           = "30"

    dimensions = {
        ClusterName = "${aws_ecs_cluster.main.name}"
    }

    alarm_description = "This metric monitor EC2 instance CPU utilization"
    actions_enabled = true
    alarm_actions     = ["${aws_autoscaling_policy.scale_down_policy.arn}"]
}
