# Bucket Enforce Versioning Enabled

resource "google_storage_bucket" "versioning-example" {
  name     = "versioning-bucket-232151213"
  location = "US"
  versioning {
    enabled = true
  }
}
