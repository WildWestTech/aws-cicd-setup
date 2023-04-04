# aws-cicd-setup
Setting up the initial requirements for CICD using Terraform with AWS and GitHub Actions.

General Overview:

Using CI/CD assumes you're working in a rather mature organization with multiple environments (Dev, Prod, etc).  Point of WildWestTech is simply to explore and test different tools and perform some troubleshooting along the way.  Keeping that in mind, I plan on running through some of the initial setup and demos for CI/CD, but I won't put everything in the pipeline.  Just enough to show a working proof of concept.

Round 1 Thoughts.  We'll have a few major components:
- AWS will need to communicate with GitHub.  We'll need to create an OICD provider in AWS within IAM for GitHub to be able to communicate with AWS.
- Who does the communicating?  We'll need to create a role an IAM role within AWS that can be assumed by GitHub, so that it can perform actions on our behalf.
- When and how will it communicate?  We like Terraform, so we want our role to perform terraform to apply changes to our state file.  We want this to occur when certain actions happen within GitHub... I'm referring to GitHub Actions.
- What is GitHub Actions?  GitHub Actions is the CI/CD tool we'll be using.  We'll have a small yaml file that runs command line code on small virtual machines, when we do things like merge or make pull requests on the repo.

Round 2 Thoughts.  What came first, the chicken or the egg?
- Since we're planning on setting up an automated process for CI/CD, we need to "manually" setup some of the pre-reqs first.
- We don't want our CI/CD process to overwrite it's own permissions, it's own state file, or really anything that would cause our process to lock itself out.  For these reasons, we're setting up some of the baseline processes here, then we'll implement CI/CD in another repo.
