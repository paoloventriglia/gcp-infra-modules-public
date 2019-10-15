resource "google_container_cluster" "primary" {
  name                     = var.name
  location                 = var.location
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.network
  subnetwork               = var.subnetwork

  master_auth {
    username = "admin"
    password = "u78]Wr;^pdCNnXZ_"

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = var.name
  location   = var.location
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = var.preemptible
    machine_type = var.machine_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}