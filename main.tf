# Bigquery Prevent Domain Wide Access
provider "google" {
  project     = "faux-dev"
  region      = "us-central1"
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "example_dataset"
  friendly_name               = "test"
  description                 = "This is a test description"
  location                    = "US"
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"
  }

  access {
    role          = "OWNER"
    user_by_email = "bob@bob.com"
  }

  access {
    role          = "READER"
    user_by_email = "bob@standardindustries.com"
  }
  access {
    role          = "READER"
    user_by_email = "bob@gaf.com"
  }
  access {
    role          = "READER"
    user_by_email = "bob@sampledomain.com"
  }
  access {
    role          = "READER"
    user_by_email = "bob@example.com.com"
  }

}
