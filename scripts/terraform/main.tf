
terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "3.5.0"
        }
    }
}


provider "google" {
    project = "my-project"
    region  = "us-central1"
    zone    = "us-central1-c"
}


resource "google_compute_instance" "vm01" {
    name = "vm01"
    machine_type = "f1-micro"
    zone = "us-central1-c"

    boot_disk {
        initialize_params {
        image = "debian-cloud/debian-9"
        }
    }

    network_interface {
        network = "default"
        access_config {
        }
    }
}
