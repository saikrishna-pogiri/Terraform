resource "aws_s3_bucket" "terraform-bucket" {
 bucket = "terraform-bucket-saijhanshi-0987"

 lifecycle_rule {
   enabled = true

transition {

 days = 30
 storage_class = "STANDARD_IA"

}

transition {

  days = 60
  storage_class = "GLACIER"
}

 }

 }
