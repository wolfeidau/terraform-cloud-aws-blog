# terraform-cloud-aws-blog

This is the code related to a blog post I am posting about deploying infrastructure to AWS using Terraform Cloud without using IAM User Credentials.

# Contents

I have included:

* cfn/ - CloudFormation templates 
* terraform/ - Terraform configuration

**Note:** You will want to customise the IAM policy for the role that Terraform Cloud assumes to cater for your specific needs.

# License

This application is released under Apache 2.0 license and is copyright [Mark Wolfe](https://www.wolfe.id.au).