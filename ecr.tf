resource "aws_ecr_repository" "ms_employee" {
  name                 = "ms-employee"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository" "ms_working_hours_entry" {
  name                 = "ms-working-hours-entry"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository" "ms_working_hours_registry" {
  name                 = "ms-working-hours-registry"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository" "ms_report" {
  name                 = "ms-report"
  image_tag_mutability = "MUTABLE"
}