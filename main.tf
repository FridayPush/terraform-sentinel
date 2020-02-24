# google_storage_object_acl is not tested, allowing individual
# objects to be declared public if necessary. 
# This file was used to generate the Mocks for sentinel
resource "google_storage_bucket" "validate-store" {
  name     = "sentinel-test-${random_string.random.result}"
  location = "US"
}

resource "random_string" "random" {
  length = 6
  special = false
}

#####
# Prevent Public buckets through object level defaults
resource "google_storage_default_object_acl" "public-object-default-acl" {
  bucket = "${google_storage_bucket.validate-store.name}"
  role_entity = [
    "OWNER:user-my.email@gmail.com",
    "READER:allUsers",
  ]
}
resource "google_storage_bucket_acl" "pubread_bucket_acl" {
  bucket = "${google_storage_bucket.validate-store.name}"
  predefined_acl = "publicRead"
}

resource "google_storage_bucket_acl" "all_authn_bucket_acl" {
  bucket = "${google_storage_bucket.validate-store.name}"
  predefined_acl = "authenticatedRead"
}

resource "google_storage_bucket_acl" "pubreadwrite_bucket_acl" {
  bucket = "${google_storage_bucket.validate-store.name}"
  default_acl = "publicReadWrite"
}
