resource "random_string" "random" {
  count = var.instance_count
  length = 8
  lower = "true"
}

resource "google_compute_instance" "vm" {
  count        = var.instance_count
  name         = element(random_string.random.*.id, count.index)
  machine_type = var.machine_type
  zone         = var.zone

  tags = element(google_compute_instance.vm.*.name, count.index)

  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  network_interface {
    network = var.network
    subnetwork = var.subnetwork

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    name = element(google_compute_instance.vm.*.name, count.index)
  }
  labels = {
    name = element(google_compute_instance.vm.*.name, count.index)
    env  = "dev"
    team = "research"
  }

  metadata_startup_script = data.template_file.metadata_startup_script.template

}