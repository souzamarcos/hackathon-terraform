resource "random_password" "db_master_password"{
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_db_subnet_group" "default" {
  name       = "rds-subnet-group"
  subnet_ids = aws_subnet.private_subnets.*.id

  tags = {
    Name = "RDS subnet group"
  }
}

resource "aws_db_instance" "default" {
  depends_on                    = [random_password.db_master_password]
  allocated_storage             = 5
  db_name                       = "burger"
  engine                        = "mysql"
  engine_version                = "8.0.34"
  allow_major_version_upgrade   = true
  instance_class                = "db.t3.micro"
  username                      = "fiap"
  password                      = random_password.db_master_password.result
  parameter_group_name          = "default.mysql8.0"
  publicly_accessible           = true
  db_subnet_group_name          = aws_db_subnet_group.default.name
  availability_zone             = var.azs.*
}
