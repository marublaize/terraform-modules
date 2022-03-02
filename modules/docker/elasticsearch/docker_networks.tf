resource "docker_network" "elasticsearch_network" {
  name = "elasticsearch_network"
  driver = "bridge"
}
