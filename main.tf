terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.21.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "dmajoros_testimages" {
  name         = "dmajoros/testimages:latest"
  keep_locally = false
}

resource "docker_container" "mycv" {
  count = "2"
  image = docker_image.dmajoros_testimages.image_id
  name  = "mycv${1 + count.index}"
  ports {
    internal = 80
    external = "800${1 + count.index}"
  }
}
