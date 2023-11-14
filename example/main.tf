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
