terraform {
  required_version = ">=0.12.0"
}

provider "digitalocean" {}

resource "digitalocean_droplet" "this" {
  name   = var.droplet_name
  image  = var.image_name
  region = var.region
  size   = var.size

  private_networking = var.private_networking
  vpc_uuid           = var.vpc_id
  ssh_keys           = var.ssh_keys
}

resource "digitalocean_project_resources" "droplet_project" {
  count = var.project_name != "" ? 1 : 0

  project = var.project_name
  resources = [
    digitalocean_droplet.this.urn
  ]
}

resource "digitalocean_record" "droplet_internal" {
  count = var.domain_name != "" ? 1 : 0

  domain = var.domain_name
  type   = "A"
  name   = "db"
  value  = digitalocean_droplet.this.ipv4_address
}

resource "digitalocean_firewall" "web_firewall" {
  name = "ssh-db-access"
  droplet_ids = [
    digitalocean_droplet.this.id
  ]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "5432"
    source_addresses = [var.internal_ip_range]
  }
}
