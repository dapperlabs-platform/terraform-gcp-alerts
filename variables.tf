variable "pd_gcp_integration_key" {
  type        = string
  description = "The Integration Key for the PagerDuty service you wish to alert."
}

variable "alerts" {
  type = map(object({
    filter           = string
    label_extractors = map(string)
  }))
  description = "A map object representing all the alerts you wish to create. NOTE: For label_extractors, each value in the key,value pair must be wrapped in the following: EXTRACT() or REGEXP_EXTRACT(). Documentation on format here: https://cloud.google.com/logging/docs/reference/v2/rest/v2/projects.metrics#LogMetric.FIELDS.value_extractor "
}

variable "project" {
  type        = string
  description = "The GCP project where you want the resources to be built in"
}

variable "combiner" {
  type        = string
  description = "How to combine the results of multiple conditions to determine if an incident should be opened. Possible values are AND, OR, and AND_WITH_MATCHING_RESOURCE"
  default     = "OR"
}

variable "enabled" {
  type        = bool
  description = "If set to true, the alert is enabled. If set to false, it is disabled"
}

variable "notification_rate_limit" {
  type = string
  description = "Alerts of the same type will not cause another notification if it occurs within this time period (must be set in seconds, minimum is 300). Ex: if this is set to '300s' then if two alerts of the same kind are triggered within 5 minutes, only one alert notification will get sent."
  default = "300s"
}