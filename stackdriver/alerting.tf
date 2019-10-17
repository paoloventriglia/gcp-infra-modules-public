resource "google_monitoring_notification_channel" "email" {
  display_name = var.channel_name
  type         = var.channel_type
  labels = {
    email_address = var.email_address
  }
}

resource "google_monitoring_group" "basic" {
  display_name = var.group_name
  filter       = var.group_filter
}

resource "google_monitoring_uptime_check_config" "http" {
  display_name = var.uptime_check_name
  timeout      = "60s"


  http_check {
    path = "/index.html"
    port = "80"
  }

  resource_group {
    resource_type = "gce_instance"
    group_id      = google_monitoring_group.basic.id
  }
}

resource "google_monitoring_alert_policy" "uptime_alert" {
  display_name          = var.uptime_alert_name
  notification_channels = [google_monitoring_notification_channel.email.id]
  combiner              = "OR"
  conditions {
    display_name = var.uptime_alert_name
    condition_threshold {
      filter          = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" resource.type=\"gce_instance\" metric.label.\"check_id\"=\"${google_monitoring_uptime_check_config.http.uptime_check_id}\""
      threshold_value = "1"
      comparison      = "COMPARISON_LT"
      duration        = var.cpu_max_theshold_duration
      trigger {
        count = "1"
      }
      aggregations {
        alignment_period     = "60s"
        cross_series_reducer = "REDUCE_COUNT_TRUE"
        per_series_aligner   = "ALIGN_NEXT_OLDER"
      }
    }
  }
  user_labels = {
    name = var.uptime_alert_name
  }
  documentation {
    content = "VM CPU High"
  }

}

resource "google_monitoring_alert_policy" "vm_cpu_utilization" {
  display_name = var.cpu_alert_name
  combiner     = "OR"
  conditions {
    display_name = var.cpu_alert_name
    condition_threshold {
      filter          = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\" AND resource.label.\"instance_id\"=\"${google_compute_instance.vm.instance_id}\""
      threshold_value = var.cpu_alter_max_threshold
      comparison      = "COMPARISON_GT"
      duration        = var.cpu_max_theshold_duration
      trigger {
        count = "1"
      }
      aggregations {
        alignment_period   = var.alignment_period
        per_series_aligner = var.cpu_aligner
      }
    }
  }
  user_labels = {
    name = var.cpu_alert_name
  }
  notification_channels = [google_monitoring_notification_channel.email.id]

  documentation {
    content = "VM CPU High"
  }
}