resource "google_monitoring_alert_policy" "alert_policy" {
  display_name          = var.display_name
  combiner              = var.combiner
  project               = var.project
  notification_channels = var.notification_channels
  enabled               = var.enabled

  alert_strategy {
    notification_rate_limit {
      period = var.notification_rate_limit
    }
  }


  // TODO: update module for handling other alert types
  conditions {
    display_name = var.display_name
    condition_matched_log {
      filter           = var.filter
      label_extractors = var.label_extractors
    }
  }
}
