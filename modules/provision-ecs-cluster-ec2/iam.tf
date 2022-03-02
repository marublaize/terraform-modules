resource "aws_iam_role" "iam_role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com",
          "ecs.amazonaws.com",
          "ecs-tasks.amazonaws.com"
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "iam_instance_profile" {
  role = "${aws_iam_role.iam_role.id}"
}

resource "aws_iam_role_policy_attachment" "AdministratorAccess" {
  role       = "${aws_iam_role.iam_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "AmazonECSTaskExecutionRolePolicy" {
  role = "${aws_iam_role.iam_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerServiceforEC2Role" {
  role       = "${aws_iam_role.iam_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerServiceRole" {
  role = "${aws_iam_role.iam_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}