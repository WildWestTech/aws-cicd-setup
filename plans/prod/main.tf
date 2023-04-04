#===========================================================

#===========================================================
terraform {
    backend "s3" {
        bucket          = "wildwesttech-terraform-backend-state-prod"
        key             = "aws-cicd-prod/terraform.tfstate"
        region          = "us-east-1"
        dynamodb_table  = "terraform-state-locking"
        encrypt         = true
        profile         = "prod"
    }

}
provider "aws" {
    profile = "prod"
    region  = "us-east-1"
}

module "oicd" {
    source  = "../../modules/oicd"
}

module "iam-role" {
    source  = "../../modules/iam-role"
    depends_on = [
      module.oicd
    ]
}