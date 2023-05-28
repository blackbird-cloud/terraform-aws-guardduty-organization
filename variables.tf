variable "s3_logs" {
  type        = bool
  default     = false
  description = "(Optional) Set to true if you want S3 data event logs to be automatically enabled for new members of the organization. Default: `false`"
}

variable "kubernetes_audit_logs" {
  type        = bool
  default     = true
  description = "(Optional) If true, enables Kubernetes audit logs as a data source for Kubernetes protection. Defaults to `true`."
}

variable "scan_ec2_instance_with_findings_ebs_volumes" {
  type        = bool
  default     = true
  description = "(Optional) If true, enables Malware Protection for all new accounts joining the organization. Defaults to `true`."
}

variable "auto_enable_organization_members" {
  type        = string
  default     = "ALL"
  description = "(Optional) Indicates the auto-enablement configuration of GuardDuty for the member accounts in the organization. Valid values are ALL, NEW, NONE. Defaults to `ALL`."
}
