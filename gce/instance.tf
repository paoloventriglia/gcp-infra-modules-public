resource "random_string" "random" {
  count   = var.instance_count
  length  = 8
  lower   = "true"
  upper   = "false"
  number  = "false"
  special = "false"
}

resource "google_compute_instance" "vm" {
  count        = var.instance_count
  name         = "${var.org}-${element(random_string.random.*.id, count.index)}"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["${var.org}-${element(random_string.random.*.id, count.index)}"]


  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  network_interface {
    network    = var.network
    subnetwork = var.subnetwork


    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    name = "${var.org}-${element(random_string.random.*.id, count.index)}"
  }
  labels = {
    name = "${var.org}-${element(random_string.random.*.id, count.index)}"
    env  = "dev"
    team = "research"
  }

  metadata_startup_script = data.template_file.metadata_startup_script.template

}