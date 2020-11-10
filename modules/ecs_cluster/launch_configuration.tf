resource "aws_launch_configuration" "main" {
    name_prefix          = "${aws_ecs_cluster.main.name}-launch-config-"
    key_name             = "${var.key_pair}"
    image_id             = "${data.aws_ami.latest.id}"
    instance_type        = "${var.instance_type}"
    iam_instance_profile = "${aws_iam_instance_profile.iam_profile.id}"
    security_groups      = ["${aws_security_group.ecs_main.id}"]
    enable_monitoring    = false
    associate_public_ip_address = false
    user_data            = "${data.template_file.user_data.rendered}"

    lifecycle {
        create_before_destroy = true  
    }
}

data "template_file" "user_data" {
    template = "${file("${path.module}/user_data.tpl")}"
    vars = {
        ecs_cluster = "${aws_ecs_cluster.main.name}"
        region      = "${var.region}"
    }
}

data "aws_ami" "latest" {
    most_recent = true
    owners      = ["591542846629"] # AWS
    filter {
        name   = "name"
        values = ["amzn2-ami-ecs-hvm-2*"]
    }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}
