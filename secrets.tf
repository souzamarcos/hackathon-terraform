resource "aws_secretsmanager_secret" "db_product" {
  name = "db_product"
}

resource "aws_secretsmanager_secret" "db_order" {
  name = "db_order"
}


resource "aws_secretsmanager_secret" "db_payment" {
  name = "db_payment"
}

resource "aws_secretsmanager_secret_version" "db_product" {
  depends_on = [aws_db_instance.db_product]
  secret_id     = aws_secretsmanager_secret.db_product.id
  secret_string = <<EOF
{
  "username": "${aws_db_instance.db_product.username}",
  "password": "${random_password.db_product_password.result}",
  "host": "${aws_db_instance.db_product.endpoint}",
  "port": ${aws_db_instance.db_product.port}
}
EOF
}

resource "aws_secretsmanager_secret_version" "db_order" {
  depends_on = [aws_db_instance.db_order]
  secret_id     = aws_secretsmanager_secret.db_order.id
  secret_string = <<EOF
{
  "username": "${aws_db_instance.db_order.username}",
  "password": "${random_password.db_order_password.result}",
  "host": "${aws_db_instance.db_order.endpoint}",
  "port": ${aws_db_instance.db_order.port}
}
EOF
}

resource "aws_secretsmanager_secret_version" "db_payment" {
  depends_on = [aws_db_instance.db_payment]
  secret_id     = aws_secretsmanager_secret.db_payment.id
  secret_string = <<EOF
{
  "username": "${aws_db_instance.db_payment.username}",
  "password": "${random_password.db_payment_password.result}",
  "host": "${aws_db_instance.db_payment.endpoint}",
  "port": ${aws_db_instance.db_payment.port}
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
    "token_jwt_issuer" : "https://fiap.auth0.com/"
  })
}
