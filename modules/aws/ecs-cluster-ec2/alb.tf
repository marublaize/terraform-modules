resource "aws_alb" "main" {
    name            = "${aws_ecs_cluster.main.name}-alb"
    internal        = true
    subnets         = ["${var.dmz_subnet_1}", "${var.dmz_subnet_2}"]
    security_groups = ["${aws_security_group.alb.id}"]
    enable_http2    = "true"
    idle_timeout    = 30
    tags = {
        project     = "${aws_ecs_cluster.main.name}"
        region      = "${var.region}"
        function    = "application-load-balancer"
        owner       = "devops"
    }
}
