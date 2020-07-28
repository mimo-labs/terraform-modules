output "project_id" {
  value = digitalocean_project.this.id
}

output "internal_domain_name" {
  value = digitalocean_domain.internal_domain.name
}

output "external_domain_name" {
  value = digitalocean_domain.external_domain.name
}
