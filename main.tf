resource "google_project_iam_binding" "project" {
  project = "your-project-id"
  role    = "Owner"

  members = [
    "user:jane@example.com",
  ]
}
