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

  policy = jsonencode({
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Sid": "AllowDynamoDB",
            "Effect" : "Allow",
            "Action" : ["dynamodb:*"],
            "Resource" : "${aws_dynamodb_table.tf_clients_table.arn}"
          },
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
              "xray:PutTraceSegments",
              "secretsmanager:GetSecretValue"
            ],
            "Resource": "*"
          }
        ]
      })
}

resource "aws_iam_policy" "iam_policy_for_eks_node_group" {
  name = "eks-node-group-policy"
  path = "/"

  policy = jsonencode({
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Sid": "AllowDynamoDB",
            "Effect" : "Allow",
            "Action" : ["dynamodb:*"],
            "Resource" : "${aws_dynamodb_table.tf_clients_table.arn}"
          }
        ]
      })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "aws_iam_role_policy_attachment" {
  role       = "${aws_iam_role.iam_role_for_lambda.name}"
  policy_arn = "${aws_iam_policy.iam_policy_for_lambda.arn}"
}