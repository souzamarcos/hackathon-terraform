resource "aws_dynamodb_table" "tf_employee_table" {
  name = "tf-employee-table"
  billing_mode = "PROVISIONED"
  read_capacity= "2"
  write_capacity= "2"
  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "email"
    type = "S"
  }
  
  global_secondary_index {
    name               = "email"
    hash_key           = "email"
    write_capacity     = 2
    read_capacity      = 2
    projection_type    = "ALL"
  }
}