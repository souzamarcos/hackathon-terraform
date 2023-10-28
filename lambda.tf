resource "aws_lambda_function" "java_lambda_function" {
  runtime          = "java17"
  //filename      = "s3://fiap-burger/lambda-client-auth/lambda-tech-challenge-fast-food-1.0-SNAPSHOT-plain.jar"
  //source_code_hash = "${base64sha256(file("s3://fiap-burger/lambda-client-auth/lambda-tech-challenge-fast-food-1.0-SNAPSHOT-plain.jar"))}"
  s3_bucket = "fiap-burger"
  s3_key = "lambda-client-auth/lambda-tech-challenge-fast-food-1.0-SNAPSHOT-plain.jar"
  function_name = "java_lambda_function"

  handler          = "com.fiap.burger.handler.LambdaHandler::handleRequest"
  timeout = 60
  memory_size = 256
  role             = "${aws_iam_role.iam_role_for_lambda.arn}"
  depends_on   = ["aws_cloudwatch_log_group.log_group"]

}