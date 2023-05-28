[![blackbird-logo](https://raw.githubusercontent.com/blackbird-cloud/terraform-module-template/main/.config/logo_simple.png)](https://blackbird.cloud)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_guardduty_detector.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_detector) | resource |
| [aws_guardduty_organization_configuration.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_organization_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_enable_organization_members"></a> [auto\_enable\_organization\_members](#input\_auto\_enable\_organization\_members) | (Optional) Indicates the auto-enablement configuration of GuardDuty for the member accounts in the organization. Valid values are ALL, NEW, NONE. Defaults to `ALL`. | `string` | `"ALL"` | no |
| <a name="input_kubernetes_audit_logs"></a> [kubernetes\_audit\_logs](#input\_kubernetes\_audit\_logs) | (Optional) If true, enables Kubernetes audit logs as a data source for Kubernetes protection. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_s3_logs"></a> [s3\_logs](#input\_s3\_logs) | (Optional) Set to true if you want S3 data event logs to be automatically enabled for new members of the organization. Default: `false` | `bool` | `false` | no |
| <a name="input_scan_ec2_instance_with_findings_ebs_volumes"></a> [scan\_ec2\_instance\_with\_findings\_ebs\_volumes](#input\_scan\_ec2\_instance\_with\_findings\_ebs\_volumes) | (Optional) If true, enables Malware Protection for all new accounts joining the organization. Defaults to `true`. | `bool` | `true` | no |

## Outputs

No outputs.

## About

We are [Blackbird Cloud](https://blackbird.cloud), Amsterdam based cloud consultancy, and cloud management service provider. We help companies build secure, cost efficient, and scale-able solutions.

Checkout our other :point\_right: [terraform modules](https://registry.terraform.io/namespaces/blackbird-cloud)

## Copyright

Copyright © 2017-2023 [Blackbird Cloud](https://blackbird.cloud)
