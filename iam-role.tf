# lambda role
resource "aws_iam_role" "iam_role_for_lambda" {
  name = "lambda-invoke-role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
}
EOF
}

# lambda policy
resource "aws_iam_policy" "iam_policy_for_lambda" {
  name = "lambda-invoke-policy"
  path = "/"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "LambdaPolicy",
        "Effect": "Allow",
        "Action": [
          "cloudwatch:PutMetricData",
          "ec2:DescribeNetworkInterfaces",
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "xray:PutTelemetryRecords",
          "xray:PutTraceSegments"
        ],
        "Resource": "*"
      }
    ]
  }
EOF
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "aws_iam_role_policy_attachment" {
  role       = "${aws_iam_role.iam_role_for_lambda.name}"
  policy_arn = "${aws_iam_policy.iam_policy_for_lambda.arn}"
}

resource "aws_iam_policy" "dynamodb-lambda-policy" {
  name = "dynamodb_lambda_policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : ["dynamodb:*"],
        "Resource" : "${aws_dynamodb_table.tf_clients_table.arn}"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "aws_iam_role_policy_dynamodb_attachment" {
  role       = "${aws_iam_role.iam_role_for_lambda.name}"
  policy_arn = "${aws_iam_policy.dynamodb-lambda-policy.arn}"
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role = aws_iam_role.iam_role_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}