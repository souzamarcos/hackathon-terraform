resource "aws_ecr_repository" "burger-application" {
  name                 = "burger-application"
  image_tag_mutability = "MUTABLE"
}