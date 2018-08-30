resource "aws_cloudwatch_event_rule" "ec2_events" {
  name        = "CaptureEC2Events"
  description = "Capture EC2 Events"

  event_pattern = <<PATTERN
  {
  "detail-type": [
    "AWS API Call via CloudTrail"
  ],
  "source": [
    "aws.ec2"
  ],
  "detail": {
    "eventName": [
      "RunInstances",
      "TerminateInstances",
      "AcceptVpcPeeringConnection",
      "AssociateAddress",
      "CreateInternetGateway",
      "CreateRoute",
      "CreateRouteTable",
      "CreateSecurityGroup",
      "CreateVpc",
      "CreateVpcPeeringConnection",
      "DeleteInternetGateway",
      "DeleteRoute",
      "DeleteRouteTable",
      "DeleteSecurityGroup",
      "DeleteVpc",
      "DeleteVpcPeeringConnection",
      "DetachInternetGateway",
      "ReplaceRoute",
      "AllocateAddress",
      "AssociateAddress",
      "DisassociateAddress",
      "ReleaseAddress",
      "AttachNetworkInterface",
      "CreateNetworkInterface",
      "DeleteNetworkInterface",
      "DetachNetworkInterface",
      "UnassignIpv6Addresses",
      "UnassignPrivateIpAddresses"
    ]
  }
  }
PATTERN
}

resource "aws_cloudwatch_event_target" "ec2_sns" {
  rule      = "${aws_cloudwatch_event_rule.ec2_events.name}"
  target_id = "SendToSNS"
  arn       = "${var.sns_topic_arn}"
}
