terraform {
  backend "s3" {
    bucket = "iop-terraform-state"
    key    = "services/cloudwatchevents"
    region = "us-east-1"
  }
}
