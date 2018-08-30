resource "aws_cloudwatch_event_rule" "rds_events" {
  name        = "CaptureRDSEvents"
  description = "Capture RDS Events"

  event_pattern = <<PATTERN
{
  "detail-type": [
    "AWS API Call via CloudTrail"
  ],
  "source": [
    "aws.rds"
  ],
  "detail": {
    "eventName": [
      "CreateDBCluster",
      "CreateDBInstance",
      "DeleteDBCluster",
      "DeleteDBInstance"
    ]
  }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "rds_sns" {
  rule      = "${aws_cloudwatch_event_rule.rds_events.name}"
  target_id = "SendToSNS"
  arn       = "arn:aws:sns:us-east-1:619481567101:dev-use1-sns-raptor-01"
}
