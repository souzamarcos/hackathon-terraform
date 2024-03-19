resource "aws_secretsmanager_secret" "db_working_hours" {
  name = "rds_working_hours"
}

resource "aws_secretsmanager_secret_version" "db_working_hours" {
  depends_on = [aws_db_instance.db_working_hours]
  secret_id     = aws_secretsmanager_secret.db_working_hours.id
  secret_string = <<EOF
{
  "username": "${aws_db_instance.db_working_hours.username}",
  "password": "${random_password.db_working_hours_password.result}",
  "host": "${aws_db_instance.db_working_hours.endpoint}",
  "port": ${aws_db_instance.db_working_hours.port}
}
EOF
}
