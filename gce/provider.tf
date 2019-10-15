provider "google" {
  credentials = file("../corebox-001-244109-fdd18366bb04.json")
  project     = var.project
  region      = var.region
  zone        = var.zone
}