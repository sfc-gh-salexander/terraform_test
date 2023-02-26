terraform {
  required_providers {
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = "0.25.17"
    }
  }

  backend "remote" {
    organization = "snowflake_terraform"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}

provider "snowflake" {
}

resource "snowflake_role" "role" {
  name    = "ROLE_TERRAFORM"
  comment = "ROLE for Snowflake Terraform demo"
}

resource "snowflake_role_grants" "grants" {
  role_name = "ROLE_TERRAFORM"
  users     = ["SALEXANDER"]
}

resource "snowflake_database" "db" {
  name                        = "DB_TERRAFORM"
  comment                     = "Terraform Test"
  data_retention_time_in_days = "1"
}

resource "snowflake_schema" "schema" {
  database            = "DB_TERRAFORM"
  name                = "SCHEMA_TERRAFORM"
  comment             = "Terraform Test"
  data_retention_days = "1"
}

resource "snowflake_database_grant" "grant" {
    database          = "DB_TERRAFORM"
    privilege         = "USAGE"
    roles             = [ROLE_TERRAFORM]
}
