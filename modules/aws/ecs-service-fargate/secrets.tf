resource "aws_ssm_parameter" "MY_SECRET" {
    name = "/${var.service_name}/MY_SECRET"
    value = "TVlfU0VDUkVUCg=="
    type = "String"
}