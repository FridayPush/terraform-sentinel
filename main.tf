# Bigquery Prevent Domain Wide Access
resource "google_project" "my" {
  name       = "Project with labels"
  project_id = "${var.project_name}"
}

resource "google_compute_disk" "default" {
  name = "${var.id_string}"
  type  = "pd-ssd"
  zone  = "us-central1-a"
  image = "debian-8-jessie-v20170523"
  physical_block_size_bytes = 4096
}

resource "google_pubsub_topic" "example" {
  name = "example-topic"

}

resource "google_compute_network" "vpc_network" {
  name = "vpc-network"
}


variable "id_string" {
  type = string
  default ="idstring"
}

variable "project_name" {
  type = string
  description = "Project has a description"
  default = "temp-project"
}