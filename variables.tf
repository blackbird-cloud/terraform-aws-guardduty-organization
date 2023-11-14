variable "auto_enable_organization_members" {
  type        = string
  default     = "ALL"
  description = "(Optional) Indicates the auto-enablement configuration of GuardDuty for the member accounts in the organization. Valid values are ALL, NEW, NONE. Defaults to `ALL`."
}

variable "scan_s3_data_events" {
  type        = bool
  default     = true
  description = "(Optional) Set to true if you want S3 data event logs to be automatically enabled for new members of the organization. Default: `true`."
}

variable "scan_eks_audit_logs" {
  type        = bool
  default     = true
  description = "(Optional) If true, enables Kubernetes audit logs as a data source for Kubernetes protection. Defaults to `true`."
}

variable "enable_ebs_malware_protection" {
  type        = bool
  default     = true
  description = "(Optional) If true, enables Malware Protection for all new accounts joining the organization. Defaults to `true`."
}

variable "enable_eks_runtime_monitoring" {
  type        = bool
  default     = true
  description = "(Optional) If true, enables EKS GuardDuty Add-on for EKS protection. Defaults to `true`."
}

variable "scan_rds_login_events" {
  type        = bool
  default     = true
  description = "(Optional) GuardDuty RDS Protection detects anomalous login behavior on your database instance. Defaults to `true`."
}

variable "scan_lambda_network_logs" {
  type        = bool
  default     = true
  description = "(Optional) Lambda Protection helps you identify potential security threats when an AWS Lambda function gets invoked in your AWS environment. Defaults to `true`."
}

variable "finding_publishing_frequency" {
  type        = string
  description = "(Optional) Specifies the frequency of notifications sent for subsequent finding occurrences. If the detector is a GuardDuty member account, the value is determined by the GuardDuty primary account and cannot be modified, otherwise defaults to SIX_HOURS. For standalone and GuardDuty primary accounts, it must be configured in Terraform to enable drift detection. Valid values for standalone and primary accounts: FIFTEEN_MINUTES, ONE_HOUR, SIX_HOURS. Defaults to `SIX_HOURS`."
  default     = "SIX_HOURS"
}

variable "tags" {
  type        = map(string)
  description = "(Optional) Key-value map of resource tags. If configured with a provider `default_tags` configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
}

variable "publish_destination_s3_arn" {
  type        = string
  default     = ""
  description = "(Optional) The bucket arn and prefix under which the findings get exported. Bucket-ARN is required, the prefix is optional and will be `AWSLogs/[Account-ID]/GuardDuty/[Region]/` if not provided."
}

variable "publish_destination_kms_key_arn" {
  type        = string
  default     = ""
  description = "(Optional) The ARN of the KMS key used to encrypt GuardDuty findings. GuardDuty enforces this to be encrypted."
}
