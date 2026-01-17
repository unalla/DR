terraform {
  backend "s3" {
    bucket         = "ec2_dr_failover_destroy"
    key            = "global/s3/terraform.tfstate" # The file path in the bucket
    region         = "us-east-1"
    dynamodb_table = "ec2-dr-dynamo"
    encrypt        = true # Ensures your state file is encrypted at rest
  }
}