resource "aws_ecr_repository" "ms_product" {
  name                 = "ms-product"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository" "ms_order" {
  name                 = "ms-order"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository" "ms_payment" {
  name                 = "ms-payment"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository" "ms_customer" {
  name                 = "ms-customer"
  image_tag_mutability = "MUTABLE"
}