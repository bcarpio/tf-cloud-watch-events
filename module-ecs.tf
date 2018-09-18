resource "aws_cloudwatch_event_rule" "ecs_events" {
  name        = "CaptureECSEvents"
  description = "Capture ECS Events"

  event_pattern = <<PATTERN
{
  "detail-type": [
    "AWS API Call via CloudTrail"
  ],
  "source": [
    "aws.ecs"
  ],
  "detail": {
    "eventName": [
      "CreateCluster",
      "CreateService",
      "DeleteCluster",
      "DeleteService",
      "UpdateService"
    ]
  }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "ecs_sns" {
  rule      = "${aws_cloudwatch_event_rule.ecs_events.name}"
  target_id = "SendToSNS"
  arn       = "${var.sns_topic_arn}"
}
