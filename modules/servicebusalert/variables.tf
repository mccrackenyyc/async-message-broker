variable "env_name" {
  description = "Working environment"
  type        = string
}

variable "resource_group_name" {
  description = "Monitoring resource group"
  type        = string
}

variable "scope" {
  description = "ID of service bus namespace"
  type        = string
}

variable "threshold" {
  description = "Number of messages on queues/topics before alarm trips"
  type        = number
  default     = 100
}

variable "dimension_values" {
  description = "List of queues/topics to be monitored"
  type        = list(any)
}

variable "action_group_id" {
  description = "Monitoring action group"
  type        = string
}

variable "type" {
  description = "Alert type"
  type        = string
}

variable "severity" {
  description = "Alert severity level"
  type        = number
  default     = 3
}