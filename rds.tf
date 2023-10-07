data "aws_secretsmanager_secret" "password" {
  name = "burger-db-password"
  depends_on = [aws_secretsmanager_secret.password]
}

data "aws_secretsmanager_secret_version" "password" {
  secret_id = data.aws_secretsmanager_secret.password
  depends_on = [aws_secretsmanager_secret.password]
}

resource "aws_db_instance" "default" {
  allocated_storage             = 2
  db_name                       = "mydb"
  engine                        = "mysql"
  engine_version                = "5.8"
  instance_class                = "db.t3.micro"
  username                      = "fiap"
  password                      = data.aws_secretsmanager_secret_version.password
  skip_final_snapshot           = true
}
