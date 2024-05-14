resource "aws_guardduty_detector" "default" {
  enable = true

  finding_publishing_frequency = var.finding_publishing_frequency

  datasources {
    s3_logs {
      enable = var.scan_s3_data_events
    }
    kubernetes {
      audit_logs {
        enable = var.scan_eks_audit_logs
      }
    }
    malware_protection {
      scan_ec2_instance_with_findings {
        ebs_volumes {
          enable = var.enable_ebs_malware_protection
        }
      }
    }
  }
  tags = var.tags
}

resource "aws_guardduty_organization_configuration" "default" {
  auto_enable_organization_members = var.auto_enable_organization_members

  detector_id = aws_guardduty_detector.default.id

  datasources {
    s3_logs {
      auto_enable = var.scan_s3_data_events
    }
    kubernetes {
      audit_logs {
        enable = var.scan_eks_audit_logs
      }
    }
    malware_protection {
      scan_ec2_instance_with_findings {
        ebs_volumes {
          auto_enable = var.enable_ebs_malware_protection
        }
      }
    }
  }
}

resource "aws_guardduty_organization_configuration_feature" "eks_runtime_monitoring" {
  count = var.enable_eks_runtime_monitoring ? 1 : 0

  detector_id = aws_guardduty_detector.default.id
  name        = "EKS_RUNTIME_MONITORING"
  auto_enable = var.auto_enable_organization_members

  additional_configuration {
    name        = "EKS_ADDON_MANAGEMENT"
    auto_enable = var.auto_enable_organization_members
  }
}

resource "aws_guardduty_organization_configuration_feature" "eks_audit_logs" {
  count = var.scan_eks_audit_logs ? 1 : 0

  detector_id = aws_guardduty_detector.default.id
  name        = "EKS_AUDIT_LOGS"
  auto_enable = var.auto_enable_organization_members
}

resource "aws_guardduty_organization_configuration_feature" "s3_data_events" {
  count = var.scan_s3_data_events ? 1 : 0

  detector_id = aws_guardduty_detector.default.id
  name        = "S3_DATA_EVENTS"
  auto_enable = var.auto_enable_organization_members
}

resource "aws_guardduty_organization_configuration_feature" "ebs_malware_protection" {
  count = var.enable_ebs_malware_protection ? 1 : 0

  detector_id = aws_guardduty_detector.default.id
  name        = "EBS_MALWARE_PROTECTION"
  auto_enable = var.auto_enable_organization_members
}

resource "aws_guardduty_organization_configuration_feature" "rds_login_events" {
  count = var.scan_rds_login_events ? 1 : 0

  detector_id = aws_guardduty_detector.default.id
  name        = "RDS_LOGIN_EVENTS"
  auto_enable = var.auto_enable_organization_members
}

resource "aws_guardduty_organization_configuration_feature" "lambda_network_logs" {
  count = var.scan_lambda_network_logs ? 1 : 0

  detector_id = aws_guardduty_detector.default.id
  name        = "LAMBDA_NETWORK_LOGS"
  auto_enable = var.auto_enable_organization_members
}

resource "aws_guardduty_publishing_destination" "default" {
  count = var.publish_destination_s3_arn != "" ? 1 : 0

  detector_id     = aws_guardduty_detector.default.id
  destination_arn = var.publish_destination_s3_arn
  kms_key_arn     = var.publish_destination_kms_key_arn
}
