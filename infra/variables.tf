variable "subscription_id" {
  description = "Azure subscription"
  type        = string
  default     = "20c17ce1-c880-4374-ab18-0c3a72158cf7"
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
  default     = "b920523f-f894-4add-a94b-1b0e0eee84ab"
}

variable "env_name" {
  description = "Working environment"
  type        = string
  default     = "dev"
}

variable "exampletag" {
  description = "Example use of a tag"
  type        = string
  default     = "exampletag"
}

variable "admin_upn" {
  description = "Azure AD Admin user principal name"
  type        = string
  default     = "smccracken_live.ca#EXT#@smccrackenlive.onmicrosoft.com"
}