resource "aws_cloudwatch_event_rule" "elb_events" {
  name        = "CaptureELBEvents"
  description = "Capture ELB Events"

  event_pattern = <<PATTERN
{
  "detail-type": [
    "AWS API Call via CloudTrail"
  ],
  "source": [
    "aws.elasticloadbalancing"
  ],
  "detail": {
    "eventName": [
      "CreateLoadBalancer",
      "DeleteLoadBalancer",
      "DeregisterInstancesFromLoadBalancer",
      "RegisterInstancesWithLoadBalancer"
    ]
  }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "elb_sns" {
  rule      = "${aws_cloudwatch_event_rule.elb_events.name}"
  target_id = "SendToSNS"
  arn       = "${var.sns_topic_arn}"
}
