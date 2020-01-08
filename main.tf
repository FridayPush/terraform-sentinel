# Require google_sql_database_instance backups
resource "google_sql_database_instance" "postgres" {
  name             = "postgres-instance-946848957"
  database_version = "POSTGRES_11"

  settings {
    tier = "db-f1-micro"

    backup_configuration {
      enabled = true
    }
  }
}
