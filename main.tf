
resource "google_compute_firewall" "has-logging" {
  name    = "test-firewall"
  network = "fakenetwork"
  enable_logging = true
  
  allow {
    protocol = "icmp"
  }
  source_tags = ["web"]
}

resource "google_dns_policy" "has-logging" {
  provider = google-beta

  name                      = "dns-policy"
  enable_inbound_forwarding = true

  enable_logging = true

  alternative_name_server_config {
    target_name_servers {
      ipv4_address = "172.16.1.10"
    }
    target_name_servers {
      ipv4_address = "172.16.1.20"
    }
  }

  networks {
    network_url = "fakenetwork"
  }
}

resource "google_data_fusion_instance" "has-logging" {
  provider = "google-beta"
  name = "my-instance"
  region = "us-central1"
  type = "BASIC"
  enable_stackdriver_logging = true
}

resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = "routername"
  region                             = "us-east1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_backend_service" "has-logging" {
  provider = google-beta

  name                  = "backend-service"
  health_checks         = [google_compute_health_check.health_check.self_link]
  load_balancing_scheme = "INTERNAL_SELF_MANAGED"
  locality_lb_policy    = "ROUND_ROBIN"
  log_config {
    enable = true
  }
}

resource "google_compute_health_check" "health_check" {
  provider = google-beta

  name = "health-check"
  http_health_check {
    port = 80
  }
}

resource "google_compute_region_backend_service" "has-logging" {
  name                            = "region-service"
  region                          = "us-central1"
  health_checks                   = [google_compute_health_check.default.self_link]
  connection_draining_timeout_sec = 10
  session_affinity                = "CLIENT_IP"
  
  log_config {
    enable = true
  }
}

resource "google_container_cluster" "has-logging" {
  name     = "my-gke-cluster"
  location = "us-central1"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  logging_service = "logging.googleapis.com/kubernetes"
  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_storage_bucket" "has-logging" {
  name          = "auto-expiring-bucket"
  location      = "US"
  force_destroy = true
  logging {
    log_bucket = "gs://notrealbucket/"
  }
}

