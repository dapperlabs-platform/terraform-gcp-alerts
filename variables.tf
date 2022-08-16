variable "pd_service_key" {
  type        = string
  nullable    = false
  description = "The Integration Key for the PagerDuty service you wish to alert."
}

variable "alerts" {
  type = map(object({
    filter           = string
    label_extractors = map(string)
  }))
  nullable    = false
  description = "A map object representing all the alerts you wish to create."
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
  nullable    = false
}