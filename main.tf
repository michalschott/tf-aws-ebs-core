data "aws_caller_identity" "current" {}

resource "aws_elastic_beanstalk_application" "app" {
  count       = "${length(var.apps)}"
  name        = "${join("-", compact(list(var.customer, var.project, element(var.apps, count.index))))}"
  description = "${lookup(var.app_descriptions, element(var.apps, count.index))}"
}

resource "aws_s3_bucket" "apps" {
  bucket = "${lower(join("-", compact(list(var.customer, var.project, "applications", data.aws_caller_identity.current.account_id))))}"
  acl    = "private"
  region = "${var.region}"

  lifecycle {
    prevent_destroy = true
  }

  tags {
    Terraform = "true"
    Customer  = "${var.customer}"
    Project   = "${var.project}"
  }
}

data "aws_iam_policy_document" "cloudwatch" {
  statement {
    sid = "AllowCloudWatchCreation"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }
}

resource "aws_iam_policy" "cloudwatch" {
  name   = "${join("-", compact(list(var.customer, var.project, "cloudwatch")))}"
  policy = "${data.aws_iam_policy_document.cloudwatch.json}"
}
