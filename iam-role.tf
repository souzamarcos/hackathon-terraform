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
            "Resource" : "*"
          },
          {
            "Sid": "AllowSqs",
            "Effect" : "Allow",
            "Action" : ["sqs:*"],
            "Resource" : "*"
          },
          {
            "Action": [
              "secretsmanager:GetSecretValue"
            ],
            "Effect": "Allow",
            "Resource": "*",
            "Sid": "AllowSecretGetValue"
          }
        ]
      })
}