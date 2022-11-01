terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.38.0"
    }
  }
}


provider "google" {
  project     = "test-project-360523"
  region      = var.region
}

resource "google_compute_firewall" "default" {
  name    = "${var.name}-firewall"
  network = google_compute_network.default.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000", "22"]
  }

  source_tags = ["web"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_network" "default" {
  name = "${var.name}-network"
}
resource "google_service_account" "default" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}
resource "google_compute_instance" "default" {
  name         = "ngiatech-server"
  machine_type = var.machine-type
  zone         = var.zone

#   tags = ["foo", "bar"]

  #tags = ["web", "http-server", "https-server"]
  tags = ["web"]

  

  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  network_interface {
     network = google_compute_network.default.name
    # network = "default"


    access_config {
      // Ephemeral public IP
    }
  }
   metadata = {
    enable-oslogin = "TRUE"
  }

#   metadata = {
#     foo = "bar"
#   }

  metadata_startup_script = "echo hi > /test.txt"
#   metadata_startup_script = "echo hi > /test.txt"
  scheduling {
    preemptible = true
    automatic_restart = false
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}