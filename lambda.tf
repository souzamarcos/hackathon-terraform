resource "aws_lambda_function" "java_lambda_function" {
  runtime          = "java17"
  s3_bucket = "fiap-burger"
  s3_key = "lambda-client-auth/app.zip"
  function_name = "java_lambda_function"

  handler          = "com.fiap.burger.handler.LambdaHandler::handleRequest"
  timeout = 60
  memory_size = 256
  role             = "${aws_iam_role.iam_role_for_lambda.arn}"
  depends_on   = ["aws_cloudwatch_log_group.log_group"]

}