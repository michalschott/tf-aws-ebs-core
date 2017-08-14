data "aws_caller_identity" "current" {}

resource "aws_elastic_beanstalk_application" "app" {
  count       = "${length(var.apps)}"
  name        = "${var.customer}-${element(var.apps, count.index)}"
  description = "${lookup(var.app_descriptions, element(var.apps, count.index))}"
}

resource "aws_s3_bucket" "apps" {
  bucket = "${lower(var.customer)}-applications-${data.aws_caller_identity.current.account_id}"
  acl    = "private"
  region = "${var.region}"

  lifecycle {
    prevent_destroy = true
  }

  tags {
    Terraform = "true"
    Customer  = "${var.customer}"
  }
}
