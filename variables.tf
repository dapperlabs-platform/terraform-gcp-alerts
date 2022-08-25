variable "project" {
  type        = string
  description = "The GCP project where you want the resources to be built in"
}

variable "notification_channels" {
  type        = list(string)
  description = "A list of the notification channels full REST resource names. The syntax is: projects/[PROJECT_ID]/notificationChannels/[CHANNEL_ID]"
}

variable "display_name" {
  type        = string
  description = "The name of the alert as it will appear in GCP"
}

variable "combiner" {
  type        = string
  description = "How to combine the results of multiple conditions to determine if an incident should be opened. Possible values are AND, OR, and AND_WITH_MATCHING_RESOURCE"
  default     = "OR"
  nullable    = false

  validation {
    condition     = var.combiner == "OR" || var.combiner == "AND" || var.combiner == "AND_WITH_MATCHING_RESOURCE"
    error_message = "Combiner must be one of OR, AND, or AND_WITH_MATCHING_RESOURCE. Documentation here: https://cloud.google.com/monitoring/api/ref_v3/rest/v3/projects.alertPolicies#conditioncombinertype ."
  }
}

variable "enabled" {
  type        = bool
  description = "If true the alert will trigger the notification channel. If false, the alert will not trigger the notification channel."
}

variable "notification_rate_limit" {
  type        = string
  description = "Alerts of the same type will not cause another notification if it occurs within this time period (must be set in seconds, minimum is 300). Ex: if this is set to '300s' then if two alerts of the same kind are triggered within 5 minutes, only one alert notification will get sent."
  default     = "300s"
  nullable    = false

  validation {
    condition     = length(regexall("^[0-9]+s", var.notification_rate_limit)) == 1 && parseint(regexall("^[0-9]+", var.notification_rate_limit)[0], 10) >= 300 && substr(var.notification_rate_limit, -1, -1) == "s"
    error_message = "Must be a value given in seconds (i.e. ends with 's') that is greater than or equal to 300 seconds (5 minutes)."
  }
}

variable "filter" {
  type        = string
  description = "The filter you would like to match logs against."
}

variable "label_extractors" {
  type        = map(string)
  description = "Each entry in this map is a specification for how data should be extracted from log entries that match the filter. Can be used in the documentation"
}

variable "documentation" {
  type        = string
  description = "Documentation that is included with notifications and incidents related to this policy"
}
