resource "google_container_cluster" "fail_cluster" {
  name     = "my-gke-cluster"
  location = "us-central1"

  initial_node_count       = 1
}
