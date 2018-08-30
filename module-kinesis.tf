resource "aws_cloudwatch_event_rule" "kinesis_events" {
  name        = "CaptureKinesisEvents"
  description = "Capture Kinesis Events"

  event_pattern = <<PATTERN
{
  "detail-type": [
    "AWS API Call via CloudTrail"
  ],
  "source": [
    "aws.kinesis"
  ],
  "detail": {
    "eventName": [
      "CreateStream",
      "DeleteStream"
    ]
  }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "kinesis_sns" {
  rule      = "${aws_cloudwatch_event_rule.kinesis_events.name}"
  target_id = "SendToSNS"
  arn       = "${var.sns_topic_arn}"
}
