# # Define a S3 bucket for the ALB logs
# resource "aws_s3_bucket" "alb_logs_s3_bucket" {
#   bucket = "${var.service_name}-alb-logs"
#   acl    = "log-delivery-write"

#   versioning {
#     enabled = true
#   }
# }

# # The following table contains the account IDs to use in place of elb-account-id in your bucket policy.
# # https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html

# resource "aws_s3_bucket_policy" "alb_logs_s3_bucket" {
#   bucket = aws_s3_bucket.alb_logs_s3_bucket.id
#   policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "enable_load_balancer_to_write_logs",
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "delivery.logs.amazonaws.com",
#         "AWS": "arn:aws:iam::127311923021:root"
#       },
#       "Action": "s3:PutObject",
#       "Resource": "arn:aws:s3:::${aws_s3_bucket.alb_logs_s3_bucket.bucket}/*"
#     }
#   ]
# }
# POLICY
# }

# # Create the actual ALB
# resource "aws_lb" "ecs_alb" {
#   name                              = "${var.service_name}-alb"
#   internal                          = false
#   load_balancer_type                = "application"
#   security_groups                   = ["${aws_security_group.alb_sg.id}"]
#   subnets                           = var.public_subnet_ids
#   enable_cross_zone_load_balancing  = true
#   enable_http2                      = true

#   access_logs {
#     bucket  = aws_s3_bucket.alb_logs_s3_bucket.bucket
#     enabled = true
#   }
# }

# resource "aws_lb_listener" "http" {
#   load_balancer_arn = aws_lb.ecs_alb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type = "redirect"
#     redirect {
#       port        = "443"
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }
# }

# resource "aws_lb_listener" "https" {
#   load_balancer_arn = aws_lb.ecs_alb.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = var.ssl_cert_arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.target_group.arn
#   }
# }
