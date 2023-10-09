resource "aws_secretsmanager_secret" "db_burger" {
  name = "db_burger"
}

resource "aws_secretsmanager_secret_version" "db_burger" {
  secret_id = aws_secretsmanager_secret.password.id
  secret_string = random_password.master.result
}

resource "aws_secretsmanager_secret_version" "db_burger" {
  depends_on = [aws_db_instance.default]
  secret_id     = aws_secretsmanager_secret.db_burger.id
  secret_string = <<EOF
{
  "username": "${aws_rds_cluster.default.master_username}",
  "password": "${random_password.db_master_password.result}",
  "engine": "mysql",
  "host": "${aws_rds_cluster.default.endpoint}",
  "port": ${aws_rds_cluster.default.port},
  "dbClusterIdentifier": "${aws_rds_cluster.default.cluster_identifier}"
}
EOF
}