locals {
  topics = {
    "customer-created" = ""
    "customer-updated" = ""
    "region-added"     = ""
  }
  queues = {
    "activate-customer"   = ""
    "deactivate-customer" = ""
    "email-customer"      = ""
  }
  functions = {
    "amb-send-email"              = ""
    "amb-update-customer-records" = ""
  }
}