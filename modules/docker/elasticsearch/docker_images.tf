resource "docker_image" "logstash" {
  name         = "bitnami/logstash:${var.elk_version}"
  keep_locally = false
}

resource "docker_image" "kibana" {
  name         = "bitnami/kibana:${var.elk_version}"
  keep_locally = false
}

resource "docker_image" "elasticsearch" {
  name         = "bitnami/elasticsearch:${var.elk_version}"
  keep_locally = false
}
