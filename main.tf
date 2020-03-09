# google_storage_object_acl is not tested, allowing individual
# objects to be declared public if necessary. 
# This file was used to generate the Mocks for sentinel
# Restrict Firewall Ports 
# Failure condition set port of specific protocol to an invalid value
resource "google_compute_firewall" "http-ingress" {
  name    = "test-firewall"
  network = "default"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  allow {
    protocol = "udp"
    ports    = ["3000"]
  }

  source_ranges = ["10.20.30.40/24"]
}
