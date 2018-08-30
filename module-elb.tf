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
  arn       = "arn:aws:sns:us-east-1:619481567101:dev-use1-sns-raptor-01"
}
