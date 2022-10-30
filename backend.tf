terraform {
    backend "s3" {
        bucket = "terraform-back-end1"
        region = "us-west-2"
        key = "ntierdeploy"
        dynamodb_table = "terraformbackend"
    }
}