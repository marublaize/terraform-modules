variable "ecr_repository" {
    type = string
}

variable "tag_mutability" {
    type = string
    default = "MUTABLE" # MUTABLE or IMMUTABLE
}

variable "ecr_account_id" {
    type = string
}

variable "app_account_id" {
    type = string
}
