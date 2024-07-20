terraform {
  backend "s3" {
    bucket= "fj89-my-tf-website-state"
    key = "global/s3/terraform.tfstate"
    region = "ap-southeast-1"
    dynamodb_table = "my-db-website-table"
    
  }    

}