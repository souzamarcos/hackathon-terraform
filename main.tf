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


resource "random_password" "master"{
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "password" {
  name = "burger-db-password"
}

resource "aws_secretsmanager_secret_version" "password" {
  secret_id = aws_secretsmanager_secret.password.id
  secret_string = random_password.master.result
}


data "aws_secretsmanager_secret" "password" {
  name = "burger-db-password"
}

data "aws_secretsmanager_secret_version" "password" {
  secret_id = data.aws_secretsmanager_secret.password
}

resource "aws_db_instance" "default" {
  allocated_storage             = 2
  db_name                       = "mydb"
  engine                        = "mysql"
  engine_version                = "5.8"
  instance_class                = "db.t3.micro"
  username                      = "fiap"
  password                      = data.aws_secretsmanager_secret_version.password
  skip_final_snapshot           = true
}
