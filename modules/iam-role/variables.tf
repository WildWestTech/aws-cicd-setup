#default = "repo:WildWestTech/aws-cicd-pipeline:dev"
variable "repository" {
    type = string
    default = "repo:WildWestTech/aws-cicd-pipeline:*"
}

variable "role-name" {
    type = string
    default = "cicd-role"
}