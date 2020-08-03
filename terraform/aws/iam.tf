data "aws_iam_policy" "cloudwatchAgent" {
  arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role" "Kafka-CloudWatchAgentServerRole" {
  name = var.ec2_cloudwatch_role

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Action": "sts:AssumeRole",
        "Principal": {
        "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
    }
    ]
}
EOF

  tags = {
    Owner                 = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "Kafka-CloudWatchAgentServerRole" {
  role       = var.ec2_cloudwatch_role
  policy_arn = data.aws_iam_policy.cloudwatchAgent.arn

  depends_on = [aws_iam_role.Kafka-CloudWatchAgentServerRole, data.aws_iam_policy.cloudwatchAgent]
}

resource "aws_iam_instance_profile" "Kafka-CloudWatchAgentServerRole-Profile" {
  name = var.ec2_cloudwatch_role
  role = aws_iam_role.Kafka-CloudWatchAgentServerRole.name
}