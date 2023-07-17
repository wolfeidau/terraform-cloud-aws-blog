variable "organization_name" {
  description = "the name of the organization in terraform cloud"
}

variable "project_name" {
  description = "the name of the project in terraform cloud"
}

variable "workspace_name" {
  description = "the name of the project in terraform cloud"
}

variable "audience" {
  description = "the name of the audience used by terraform cloud"
  default = "aws.workload.identity"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-2"

  default_tags {
    tags = {
      owner      = "mwolfe"
      managed_by = "terraform"
    }
  }
}

resource "aws_iam_openid_connect_provider" "app_terraform_io" {
  client_id_list  = [var.audience]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
  url             = "https://app.terraform.io"
}

resource "aws_iam_role" "terraform_deploy_role" {
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRoleWithWebIdentity"
          Condition = {
            StringEquals = {
              "app.terraform.io:aud" = var.audience
            }
            StringLike = {
              "app.terraform.io:sub" = "organization:${var.organization_name}:project:${var.project_name}:workspace:${var.workspace_name}:run_phase:*"
            }
          }
          Effect = "Allow"
          Principal = {
            Federated = aws_iam_openid_connect_provider.app_terraform_io.id
          }
        },
      ]
      Version = "2008-10-17"
    }
  )
  name                  = "terraform-cloud-oidc-access-deployment-role"
  description           = null
  force_detach_policies = false
  managed_policy_arns   = []
  max_session_duration  = 3600
  name_prefix           = null
  path                  = "/"
  permissions_boundary  = null
  inline_policy {
    name = "root"
    policy = jsonencode(
      {
        Statement = [
          {
            Action = [
              "s3:ListBucket",
            ]
            Effect   = "Allow"
            Resource = "*"
          },
        ]
        Version = "2012-10-17"
      }
    )
  }
}