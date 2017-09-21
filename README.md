tf-aws-ebs-core
----------------

This simple module is designed to:
* create S3 bucket to store application bundles
* create Elastic Beanstalk applications without any environments

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| app_descriptions | Application descriptions. | string | `<map>` | no |
| apps | Applications which will be deployed. | string | `<list>` | no |
| customer | Customer name. | string | `` | no |
| project | Project name. | string | `` | no |
| region | AWS region. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| application-names | Application names (Elastic Beanstalk). |
| applications-s3-bucket | Name of bucket with application bundles. |
| iam-policy-cloudwatch-arn | CLoudwatch policy ARN. |

Example Usage
----------------

Including an example of how to use this module:

    module "my_project" {
      source   = "git::https://github.com/michalschott/tf-aws-ebs-core.git?ref=master"
      region   = "eu-west-1"
      customer = "owner of project"

      apps = [
        "frontend",
        "backend",
      ]

      app_descriptions = {
        "frontend" = "frontend app"
        "backend"  = "backend app"
      }
    }

License
-------

MIT

Author Information
------------------

This role was created in 2017 by [Michal Schott](http://github.com/michalschott).
