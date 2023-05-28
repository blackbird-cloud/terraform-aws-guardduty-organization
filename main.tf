data "aws_guardduty_detector" "default" {}

resource "aws_guardduty_organization_configuration" "default" {
  auto_enable_organization_members = var.auto_enable_organization_members

  detector_id = data.aws_guardduty_detector.default.id

  datasources {
    s3_logs {
      auto_enable = var.s3_logs
    }
    kubernetes {
      audit_logs {
        enable = var.kubernetes_audit_logs
      }
    }
    malware_protection {
      scan_ec2_instance_with_findings {
        ebs_volumes {
          auto_enable = var.scan_ec2_instance_with_findings_ebs_volumes
        }
      }
    }
  }
}
