resource "aws_secretsmanager_secret" "database_burger" {
  name = "rds_burger"
}

resource "aws_secretsmanager_secret_version" "database_burger" {
  depends_on = [aws_db_instance.default]
  secret_id     = aws_secretsmanager_secret.database_burger.id
  secret_string = <<EOF
{
  "username": "${aws_db_instance.default.username}",
  "password": "${random_password.db_master_password.result}",
  "host": "${aws_db_instance.default.endpoint}",
  "port": ${aws_db_instance.default.port}
}
EOF
}

resource "aws_secretsmanager_secret" "token_jwt" {
  name = "token_jwt"
}

resource "random_id" "token_jwt" {
  keepers = {
    ami_id = "token_jwt_v1"
  }

  byte_length = 8
}

resource "aws_secretsmanager_secret_version" "token_jwt" {
  secret_id     = aws_secretsmanager_secret.token_jwt.id
  secret_string = jsonencode({
    "token_jwt_secret" : "${random_id.token_jwt.hex}",
    "token_jwt_issuer" : "Pos-Tech FIAP - Burger"
  })
}
