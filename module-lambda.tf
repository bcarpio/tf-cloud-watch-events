resource "aws_cloudwatch_event_rule" "lambda_events" {
  name        = "CaptureLambdaEvents"
  description = "Capture Lambda Events"

  event_pattern = <<PATTERN
{
  "detail-type": [
    "AWS API Call via CloudTrail"
  ],
  "source": [
    "aws.lambda"
  ],
  "detail": {
    "eventName": [
      "CreateFunction",
      "DeleteFunction"
    ]
  }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "lambda_sns" {
  rule      = "${aws_cloudwatch_event_rule.lambda_events.name}"
  target_id = "SendToSNS"
  arn       = "arn:aws:sns:us-east-1:619481567101:dev-use1-sns-raptor-01"
}
