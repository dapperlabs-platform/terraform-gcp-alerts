variable "pd_service_key" {
  nullable = false
}

variable "alerts" {
  type = map(map())
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
  default     = true
}