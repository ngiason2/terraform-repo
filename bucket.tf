resource "google_storage_bucket" "auto-expire" {
  name          = "ngiason-bucket123"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }
}
