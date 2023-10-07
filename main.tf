# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0
# Fiap Pos tech

terraform {
   required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "souzamarcos"

    workspaces {
      name = "terraform-github-actions"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_kms_key" "rds_kms_key" {
  description = "Chave KMS RDS"
}

resource "aws_db_instance" "default" {
  allocated_storage             = 2
  db_name                       = "mydb"
  engine                        = "mysql"
  engine_version                = "5.8"
  instance_class                = "db.t3.micro"
  manage_master_user_password   = true
  master_user_secret_kms_key_id = aws_kms_key.rds_kms_key.key_id
  username                      = "fiap"
  parameter_group_name          = "default.mysql5.7"
  skip_final_snapshot           = true
}
