<!-- BEGIN_TF_DOCS -->
# Terraform Aws Guardduty Organization Module
Terraform module to setup AWS GuardDuty in an organization

[![blackbird-logo](https://raw.githubusercontent.com/blackbird-cloud/terraform-module-template/main/.config/logo_simple.png)](https://blackbird.cloud)

## Example
```hcl
data "aws_caller_identity" "current" {}

resource "aws_guardduty_organization_admin_account" "default" {
  admin_account_id = data.aws_caller_identity.current.account_id
}

module "guardduty" {
  source  = "blackbird-cloud/guardduty-organization/aws"
  version = "~> 2"

  finding_publishing_frequency     = "FIFTEEN_MINUTES"
  auto_enable_organization_members = "ALL"

  scan_s3_data_events           = true
  scan_eks_audit_logs           = true
  enable_ebs_malware_protection = true
  enable_eks_runtime_monitoring = true
  scan_rds_login_events         = true
  scan_lambda_network_logs      = true

  tags = {
    my = "tag"
  }

  depends_on = [aws_guardduty_organization_admin_account.default]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.2 |

## Resources

| Name | Type |
|------|------|
| [aws_guardduty_detector.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_detector) | resource |
| [aws_guardduty_member.members](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_member) | resource |
| [aws_guardduty_organization_configuration.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_organization_configuration) | resource |
| [aws_guardduty_organization_configuration_feature.ebs_malware_protection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_organization_configuration_feature) | resource |
| [aws_guardduty_organization_configuration_feature.eks_audit_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_organization_configuration_feature) | resource |
| [aws_guardduty_organization_configuration_feature.eks_runtime_monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_organization_configuration_feature) | resource |
| [aws_guardduty_organization_configuration_feature.lambda_network_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_organization_configuration_feature) | resource |
| [aws_guardduty_organization_configuration_feature.rds_login_events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_organization_configuration_feature) | resource |
| [aws_guardduty_organization_configuration_feature.s3_data_events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_organization_configuration_feature) | resource |
| [aws_guardduty_publishing_destination.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_publishing_destination) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_enable_organization_members"></a> [auto\_enable\_organization\_members](#input\_auto\_enable\_organization\_members) | (Optional) Indicates the auto-enablement configuration of GuardDuty for the member accounts in the organization. Valid values are ALL, NEW, NONE. Defaults to `ALL`. | `string` | `"ALL"` | no |
| <a name="input_enable_ebs_malware_protection"></a> [enable\_ebs\_malware\_protection](#input\_enable\_ebs\_malware\_protection) | (Optional) If true, enables Malware Protection for all new accounts joining the organization. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_enable_eks_runtime_monitoring"></a> [enable\_eks\_runtime\_monitoring](#input\_enable\_eks\_runtime\_monitoring) | (Optional) If true, enables EKS GuardDuty Add-on for EKS protection. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_finding_publishing_frequency"></a> [finding\_publishing\_frequency](#input\_finding\_publishing\_frequency) | (Optional) Specifies the frequency of notifications sent for subsequent finding occurrences. If the detector is a GuardDuty member account, the value is determined by the GuardDuty primary account and cannot be modified, otherwise defaults to SIX\_HOURS. For standalone and GuardDuty primary accounts, it must be configured in Terraform to enable drift detection. Valid values for standalone and primary accounts: FIFTEEN\_MINUTES, ONE\_HOUR, SIX\_HOURS. Defaults to `SIX_HOURS`. | `string` | `"SIX_HOURS"` | no |
| <a name="input_members"></a> [members](#input\_members) | List of member accounts to invite to GuardDuty | <pre>map(object({<br/>    account_id = string<br/>    email      = string<br/>  }))</pre> | `{}` | no |
| <a name="input_publish_destination_kms_key_arn"></a> [publish\_destination\_kms\_key\_arn](#input\_publish\_destination\_kms\_key\_arn) | (Optional) The ARN of the KMS key used to encrypt GuardDuty findings. GuardDuty enforces this to be encrypted. | `string` | `""` | no |
| <a name="input_publish_destination_s3_arn"></a> [publish\_destination\_s3\_arn](#input\_publish\_destination\_s3\_arn) | (Optional) The bucket arn and prefix under which the findings get exported. Bucket-ARN is required, the prefix is optional and will be `AWSLogs/[Account-ID]/GuardDuty/[Region]/` if not provided. | `string` | `""` | no |
| <a name="input_scan_eks_audit_logs"></a> [scan\_eks\_audit\_logs](#input\_scan\_eks\_audit\_logs) | (Optional) If true, enables Kubernetes audit logs as a data source for Kubernetes protection. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_scan_lambda_network_logs"></a> [scan\_lambda\_network\_logs](#input\_scan\_lambda\_network\_logs) | (Optional) Lambda Protection helps you identify potential security threats when an AWS Lambda function gets invoked in your AWS environment. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_scan_rds_login_events"></a> [scan\_rds\_login\_events](#input\_scan\_rds\_login\_events) | (Optional) GuardDuty RDS Protection detects anomalous login behavior on your database instance. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_scan_s3_data_events"></a> [scan\_s3\_data\_events](#input\_scan\_s3\_data\_events) | (Optional) Set to true if you want S3 data event logs to be automatically enabled for new members of the organization. Default: `true`. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Key-value map of resource tags. If configured with a provider `default_tags` configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |

## Outputs

No outputs.

## About

We are [Blackbird Cloud](https://blackbird.cloud), Amsterdam based cloud consultancy, and cloud management service provider. We help companies build secure, cost efficient, and scale-able solutions.

Checkout our other :point\_right: [terraform modules](https://registry.terraform.io/namespaces/blackbird-cloud)

## Copyright

Copyright © 2017-2025 [Blackbird Cloud](https://blackbird.cloud)
<!-- END_TF_DOCS -->