data "aws_iam_policy" "cloudwatchAgent" {
  arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role" "this" {
  count = local.create ? 1 : 0
  name  = "kafka-cloud-watch-agent-role-${var.env}"

  assume_role_policy = file("${path.module}/cloudwatch-agent-policy.json")
  tags               = local.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  count      = local.create ? 1 : 0
  role       = aws_iam_role.this[0].name
  policy_arn = data.aws_iam_policy.cloudwatchAgent.arn
}

resource "aws_iam_instance_profile" "this" {
  count = local.create ? 1 : 0
  name  = "kafka-cloud-watch-agent-profile-${var.env}"
  role  = aws_iam_role.this[0].name
}