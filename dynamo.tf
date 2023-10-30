resource "aws_dynamodb_table" "tf_clients_table" {
  name = "tf-clients-table"
  billing_mode = "PROVISIONED"
  read_capacity= "30"
  write_capacity= "30"
  attribute {
    name = "cpf"
    type = "S"
  }
  hash_key = "cpf"
}