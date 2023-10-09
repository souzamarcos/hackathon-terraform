variable "username" {
  description = "Username for the master DB user."
  default = "databaseteste"
  type = string
}
variable "password" {
  description = "Password of the database"
  default = "password"
  type = string
}

resource "aws_db_instance" "default" {
  allocated_storage             = 5
  db_name                       = "burger"
  engine                        = "mysql"
  engine_version                = "5.7"
  instance_class                = "db.t3.micro"
  username                      = var.username
  password                      = var.password
  parameter_group_name          = "default.mysql5.7"
}
