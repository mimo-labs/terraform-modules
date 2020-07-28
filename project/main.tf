terraform {
  required_version = ">=0.12.0"
}

provider "digitalocean" {}

resource "digitalocean_project" "this" {
  name        = var.project_name
  environment = var.environment
}

resource "digitalocean_project_resources" "internal_domain" {
  project = digitalocean_project.this.id
  resources = [
    digitalocean_domain.internal_domain.urn
  ]
}

resource "digitalocean_domain" "internal_domain" {
  count = var.internal_domain_name != "" ? 1 : 0

  name = var.internal_domain_name
}

resource "digitalocean_domain" "external_domain" {
  count = var.external_domain_name != "" ? 1 : 0

  name = var.external_domain_name
}
