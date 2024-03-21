resource "random_password" "db_working_hours_password"{
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "random_password" "db_working_hours_replica_password"{
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_db_instance" "db_working_hours" {
  depends_on                    = [random_password.db_working_hours_password]
  allocated_storage             = 5
  identifier                    = "db-working-hours"
  db_name                       = "dbWorkingHours"
  engine                        = "mysql"
  engine_version                = "8.0.34"
  allow_major_version_upgrade   = true
  instance_class                = "db.t3.micro"
  username                      = "fiap"
  password                      = random_password.db_working_hours_password.result
  parameter_group_name          = "default.mysql8.0"
  publicly_accessible           = true
  db_subnet_group_name          = module.vpc.database_subnet_group_name
  availability_zone             = module.vpc.azs[0]
  skip_final_snapshot           = true
  backup_retention_period       = 7
  storage_encrypted             = true
}

resource "aws_db_instance" "db_working_hours_replica" {
  instance_class                = "db.t3.micro"
  skip_final_snapshot           = true
  backup_retention_period       = 7
  replicate_source_db           = aws_db_instance.db_working_hours.identifier
  parameter_group_name          = "default.mysql8.0"
  publicly_accessible           = true
  password                      = random_password.db_working_hours_replica_password.result
  db_subnet_group_name          = module.vpc.database_subnet_group_name
  availability_zone             = module.vpc.azs[0]
  storage_encrypted             = true
}
