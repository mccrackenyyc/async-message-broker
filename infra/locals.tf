locals {
  topics = {
    "threshold" = 10000
    "severity"  = 1
    "names" = {
      "customer-created" = ""
      "customer-updated" = ""
      "region-added"     = ""
    }
  }
  queues = {
    "threshold" = 50
    "severity"  = 2
    "names" = {
      "activate-customer"   = ""
      "deactivate-customer" = ""
      "email-customer"      = ""
    }
  }
  functions = {
    "amb-send-email"              = ""
    "amb-update-customer-records" = ""
  }
}