
variable "name" {
  default = ""
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
  default = "windows-server-2016-dc-v20190910"
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

variable "uptime_alert_name" {
  default = "vm_uptime_check"
  description = ""
}

variable "uptime_check_name" {
  default = ""
  description = ""
}

variable "group_name" {
  default = ""
  description = ""
}

variable "group_filter" {
  default = ""
  description = ""
}

variable "cpu_alert_name" {
  default = "vm_cpu_utilization"
  description = ""
}

variable "cpu_alter_max_threshold" {
  default = ""
  description = ""
}

variable "filter" {
  default = ""
  description = ""
}

variable "duration" {
  default = "60s"
  description = ""
}

variable "trigger_percent" {
  default = "50"
  description = ""
}

variable "trigger_count" {
  default = "1"
  description = ""
}

variable "alignment_period" {
  default = "60s"
  description = ""
}

variable "uptime_aligner" {
  default = ""
  description = ""
}

variable "cpu_aligner" {
  default = ""
  description = ""
}

variable "cpu_max_theshold_duration" {
  default = "60s"
  description = ""
}

variable "channel_name" {
  default = ""
  description = ""
}

variable "channel_type" {
  default = ""
  description = ""
}

variable "email_address" {
  default = ""
  description = ""
}

data "template_file" "metadata_startup_script" {
    template = file("${path.module}/files/startup.tpl")
}