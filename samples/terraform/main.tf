terraform {
  required_version = ">= 1.5.0"
}

variable "dataset_id" {
  type        = string
  description = "Synthetic dataset identifier for local configuration practice."
  default     = "practice_analytics"
}

locals {
  dataset_spec = {
    dataset_id = var.dataset_id
    location   = "US"
    tables = [
      {
        table_id = "orders"
        schema = jsonencode([
          { name = "order_id", type = "INTEGER", mode = "REQUIRED" },
          { name = "market", type = "STRING", mode = "NULLABLE" }
        ])
      }
    ]
  }
}

output "practice_dataset_spec" {
  description = "Local values only; no cloud provider or resources are configured."
  value       = local.dataset_spec
}
