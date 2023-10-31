resource "aws_dynamodb_table" "tf_clients_table" {
  name = "tf-clients-table"
  billing_mode = "PROVISIONED"
  read_capacity= "2"
  write_capacity= "2"
  attribute {
    name = "cpf"
    type = "S"
  }
  hash_key = "cpf"
}