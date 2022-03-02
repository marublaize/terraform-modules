# Pulls the image
resource "docker_image" "grafana" {
  name = "grafana/grafana:8.3.3"
}