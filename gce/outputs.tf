output "vm-names" {
  value = google_compute_instance.vm.*.name
}

