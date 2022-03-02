terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "docker" {
  # host    = "npipe:////.//pipe//docker_engine"
  host = "tcp://0.0.0.0:2375"
}

resource "docker_image" "grafana" {
  name = "grafana/grafana:8.3.3"
}

resource "docker_container" "grafana" {
  image = docker_image.grafana.name
  name  = "grafana"
  ports {
      internal = 3000
      external = 3000
      }
}