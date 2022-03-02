resource "docker_container" "logstash" {
  image = docker_image.logstash.name
  name  = "logstash"
  networks_advanced {
    name = docker_network.elasticsearch_network.name
  }

  ports {
    internal = 9600
    external = 9600
  }

  mounts {
    target = "/bitnami/logstash"
    type = "bind"
    source = "./bitnami/logstash"
  }

  mounts {
    target = "/opt/bitnami/logstash/pipeline"
    type = "bind"
    source = "./opt/bitnami/logstash/pipeline"
  }
}

resource "docker_container" "kibana" {
  image = docker_image.kibana.name
  name  = "kibana"
  networks_advanced {
    name = docker_network.elasticsearch_network.name
  }

  ports {
    internal = 5601
    external = 5601
  }
    
  mounts {
    target = "/bitnami/kibana"
    type = "bind"
    source = "./bitnami/kibana"
  }

  env = [
    "KIBANA_ELASTICSEARCH_URL=elasticsearch"
    ]
}

resource "docker_container" "elasticsearch" {
  image = docker_image.elasticsearch.name
  name  = "elasticsearch"
  networks_advanced {
    name = docker_network.elasticsearch_network.name
  }

  ports {
    internal = 9200
    external = 9200
  }

  mounts {
    target = "/bitnami/elasticsearch/data"
    type = "bind"
    source = "./bitnami/elasticsearch/data"
  }

  # mounts {
  #   target = "/opt/bitnami/elasticsearch/config/elasticsearch.yml"
  #   type = "bind"
  #   source = "./opt/bitnami/elasticsearch/config/elasticsearch.yml"
  # }
}