variable "name" {
  default = "gke-cluster"
  description = ""
}

variable "location" {
  default = "europe-west2-a"
  description = ""
}

variable "project" {
  default = ""
  description = ""
}

variable "region" {
  default = "europe-west2"
  description = ""
}

variable "zone" {
  default = "europe-west2-a"
  description = ""
}

variable "machine_type" {
  default = "n1-standard-1"
  description = ""
}

variable "preemptible" {
  default = "true"
  description = ""
}

variable "network" {
  default = "my-network"
  description = ""
}

variable "subnetwork" {
  default = "subnet-a"
  description = ""
}