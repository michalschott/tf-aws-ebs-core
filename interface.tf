variable "region" {
  description = "AWS region."
}

variable "customer" {
  description = "Customer name."
}

variable "apps" {
  default     = []
  description = "Applications which will be deployed."
}

variable "app_descriptions" {
  default     = {}
  description = "Application descriptions."
}

output "applications-s3-bucket" {
  value       = "${aws_s3_bucket.apps.name}"
  description = "Name of bucket with application bundles."
}

output "application-names" {
  value       = "${list(aws_elastic_beanstalk_application.app.*.name)}"
  description = "Application names (Elastic Beanstalk)."
}
