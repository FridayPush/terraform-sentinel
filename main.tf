# Bigquery Prevent Domain Wide Access
resource "google_project" "my" {
  name       = "Project with labels"
  project_id = "custom-id-hex92319232"

}

resource "google_compute_disk" "default" {
  name  = "test-disk"
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
