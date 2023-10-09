resource "aws_kms_key" "db_burger" {
  description = "RDS Database Secret"
}

resource "aws_db_instance" "default" {
  allocated_storage             = 5
  db_name                       = "burger"
  engine                        = "mysql"
  engine_version                = "5.7"
  instance_class                = "db.t3.micro"
  username                      = "fiap"
  manage_master_user_password   = true
  master_user_secret_kms_key_id = aws_kms_key.example.key_id
  parameter_group_name          = "default.mysql5.7"
}
