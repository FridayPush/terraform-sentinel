# Restrict Firewall Ports
resource "google_compute_firewall" "http-ingress" {
  name    = "test-firewall"
  network = "default"
  
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  source_tags = ["web"]
}
