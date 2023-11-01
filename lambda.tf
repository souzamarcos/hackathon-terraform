resource "aws_lambda_function" "java_lambda_function" {
  runtime          = "java17"
  s3_bucket = "fiap-burger"
  s3_key = "lambda-client-auth/lambda-client-authentication.zip"
  function_name = "java_lambda_function"

  handler          = "com.fiap.burger.handler.LambdaHandler::handleRequest"
  timeout = 60
  memory_size = 256
  role             = "${aws_iam_role.iam_role_for_lambda.arn}"
  depends_on   = [aws_cloudwatch_log_group.log_group]

  environment {
    variables = {
      CLIENTS_TABLE = aws_dynamodb_table.tf_clients_table.name
    }
  }
}

resource "aws_lambda_permission" "java_lambda_function" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.java_lambda_function.function_name}"
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_deployment.java_lambda_deploy.execution_arn}/*/*"
}