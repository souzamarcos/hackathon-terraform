resource "aws_secretsmanager_secret" "database_burger" {
  name = "database_burger"
}

resource "aws_secretsmanager_secret_version" "database_burger" {
  depends_on = [aws_db_instance.default]
  secret_id     = aws_secretsmanager_secret.database_burger.id
  secret_string = <<EOF
{
  "username": "${aws_db_instance.default.username}",
  "password": "${random_password.db_master_password.result}"
}
EOF
}