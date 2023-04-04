#===========================================================

#===========================================================
terraform {
    backend "s3" {
        bucket          = "wildwesttech-terraform-backend-state-dev"
        key             = "aws-cicd-dev/terraform.tfstate"
        region          = "us-east-1"
        dynamodb_table  = "terraform-state-locking"
        encrypt         = true
        profile         = "dev"
    }

}
provider "aws" {
    profile = "dev"
    region  = "us-east-1"
}

module "oidc" {
    source  = "../../modules/oidc"
}

module "iam-role" {
    source  = "../../modules/iam-role"
    depends_on = [
      module.oidc
    ]
}