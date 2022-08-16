resource "google_monitoring_notification_channel" "pagerduty" {
  display_name = "PagerDuty"
  type         = "pagerduty"
  sensitive_labels {
    service_key = var.pd_service_key
  }
}

resource "google_monitoring_alert_policy" "alert_policy" {
  for_each = var.alerts

  display_name = each.key
  combiner     = var.combiner
  project      = var.project
  notification_channels = [
    google_monitoring_notification_channel.pagerduty.name
  ]
  enabled = var.enabled

  // TODO: update module for handling other alert types
  conditions {
    display_name = each.key
    condition_matched_log {
      filter           = each.value.filter
      label_extractors = each.value.label_extractors
    }
  }
}
