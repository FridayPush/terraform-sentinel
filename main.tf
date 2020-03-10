# This manifest only creates a dozen or so resources that contain labels
# To produce the failed resources uncomment the bottom section

resource "google_bigquery_dataset" "dataset-w-labels" {
  dataset_id                  = "example_dataset"
  friendly_name               = "test"
  description                 = "This is a test description"
  location                    = "US"
  default_table_expiration_ms = 3600000

  labels = {
    env = "default",
    pipe = "world",
    foo = "test"
  }
}

resource "google_bigquery_table" "default" {
  dataset_id = "${google_bigquery_dataset.dataset-w-labels.dataset_id}"
  table_id   = "bar"

  labels = {
    env = "default",
    foo = "now"
  }

  schema = <<EOF
[
  {
    "name": "permalink",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "The Permalink"
  },
  {
    "name": "state",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "State where the head office is located"
  }
]
EOF
}

resource "google_compute_image" "disk-w-labels" {
  name = "example-image"

  raw_disk {
    source = "https://storage.googleapis.com/bosh-cpi-artifacts/bosh-stemcell-3262.4-google-kvm-ubuntu-trusty-go_agent-raw.tar.gz"
  }

  labels = {
    env = "default",
    foo = "what"
  }
}

resource "google_compute_instance" "instance-w-labels" {
  name         = "test"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"
  
  labels = {
    env = "test",
    foo = "bar",
    fee = "what"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

resource "google_project" "project-w-labels" {
  name       = "My Project"
  project_id = "random-project-w-labels"
  org_id     = "1234567"

  labels = {
    env = "test",
    foo = "bar"
  }
}

resource "google_container_cluster" "mixed-label" {
  name               = "marcellus-wallace"
  location           = "us-central1-a"
  initial_node_count = 3

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      env = "test",
      foo = "bar"
    }

    tags = ["foo", "bar"]
  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}

resource "google_sql_database_instance" "no-labels" {
  name             = "master-instance"
  database_version = "POSTGRES_11"
  region           = "us-central1"

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-f1-micro"
    user_labels = {
      env = "dev",
      foo = "bar"
    }
  }
}
