# Create a container
resource "docker_container" "grafana" {
  image = docker_image.grafana.name
  name  = "grafana"
  ports {
      internal = 3000
      external = 3000
      }
}