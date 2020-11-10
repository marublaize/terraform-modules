resource "aws_autoscaling_group" "main" {
    name                      = "${aws_ecs_cluster.main.name}-asg"
    vpc_zone_identifier       = ["${var.app_subnet_1}", "${var.app_subnet_2}"]
    launch_configuration      = "${aws_launch_config.main.name}"
    min_size                  = "${var.min_cluster_size}"
    max_size                  = "${var.max_cluster_size}"
    health_check_type         = "EC2"
    force_delete              = true
    health_check_grace_period = 120
    default_cooldown          = 300
    termination_policies      = ["OldestInstance", "OldestLaunchConfiguration"]

    lifecycle {
        create_before_destroy = true
    }
}
