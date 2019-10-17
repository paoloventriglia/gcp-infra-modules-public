locals {
  default_ack_deadline_seconds = 10
}

resource "google_pubsub_topic" "topic" {
  project = var.project
  name    = var.topic
  labels  = var.topic_labels
}

resource "google_pubsub_subscription" "push_subscriptions" {
  count   = length(var.push_subscriptions)
  name    = var.push_subscriptions[count.index].name
  topic   = google_pubsub_topic.topic.name
  project = var.project
  ack_deadline_seconds = lookup(
    var.push_subscriptions[count.index],
    "ack_deadline_seconds",
    local.default_ack_deadline_seconds,
  )

  push_config {
    push_endpoint = var.push_subscriptions[count.index]["push_endpoint"]

    // FIXME: This should be programmable, but nested map isn't supported at this time.
    //   https://github.com/hashicorp/terraform/issues/2114
    attributes = {
      x-goog-version = lookup(var.push_subscriptions[count.index], "x-goog-version", "v1")
    }
  }

  depends_on = [google_pubsub_topic.topic]
}

resource "google_pubsub_subscription" "pull_subscriptions" {
  count   = length(var.pull_subscriptions)
  name    = var.pull_subscriptions[count.index].name
  topic   = google_pubsub_topic.topic.name
  project = var.project
  ack_deadline_seconds = lookup(
    var.pull_subscriptions[count.index],
    "ack_deadline_seconds",
    local.default_ack_deadline_seconds,
  )

  depends_on = [google_pubsub_topic.topic]
}

