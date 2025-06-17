terraform {
  backend "s3" {
    bucket = "terraformbucketpranob"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}
