resource "aws_secretsmanager_secret" "db_burger" {
  name = "db_burger"
}

resource "aws_secretsmanager_secret_version" "db_burger" {
  depends_on = [aws_db_instance.default]
  secret_id     = aws_secretsmanager_secret.db_burger.id
  secret_string = <<EOF
{
  "username": "${aws_db_instance.default.master_username}",
  "password": "${random_password.db_master_password.result}",
  "engine": "mysql",
  "host": "${aws_db_instance.default.endpoint}",
  "port": ${aws_db_instance.default.port},
  "dbClusterIdentifier": "${aws_db_instance.default.cluster_identifier}"
}
EOF
}