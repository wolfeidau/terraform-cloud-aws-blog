# terraform-cloud-aws-blog

This is the code related to a blog post on how to [Stop using IAM User Credentials with Terraform Cloud](https://www.wolfe.id.au/2023/07/17/stop-using-iam-user-credentials-with-terraform-cloud/).

# Contents

I have included:

* cfn/ - CloudFormation templates 
* terraform/ - Terraform configuration

**Note:** You will want to customise the IAM policy for the role that Terraform Cloud assumes to cater for your specific needs.

# License

This application is released under Apache 2.0 license and is copyright [Mark Wolfe](https://www.wolfe.id.au).