terraform {
  backend "s3" {
    bucket = "terraform-tf.state"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}
