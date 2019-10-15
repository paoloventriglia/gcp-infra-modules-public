
variable "name" {
  default = ""
  description = ""
}

variable "org" {
  default = "corebox"
  description = ""
}

variable "project" {
  default = ""
  description = ""
}

variable "machine_type" {
  default = "n1-standard-1"
  description = ""
}

variable "instance_count" {
  default = "2"
}


variable "region" {
  default = "europe-west2"
  description = ""
}

variable "zone" {
  default = "europe-west2-a"
  description = ""
}

variable "image" {
  default = "centos-7-v20190916"
  description = ""
}

variable "network" {
  default = "my-network"
  description = ""
}

variable "subnetwork" {
  default = ""
  description = ""
}

data "template_file" "metadata_startup_script" {
    template = file("${path.module}/files/startup.tpl")
}