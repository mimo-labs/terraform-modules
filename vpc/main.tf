terraform {
  required_version = ">=0.12.0"
}

provider "digitalocean" {}

resource "digitalocean_vpc" "this" {
  name        = var.vpc_name
  description = var.description
  region      = var.region
  ip_range    = var.ip_range
}

resource "digitalocean_project_resources" "vpc_project" {
  count = var.project_name != "" ? 1 : 0

  project = var.project_name
  resources = [
    digitalocean_vpc.this.urn
  ]
}
