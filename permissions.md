# IAM User permissions

An IAM user is needed for Terraform to create the resources in this project.

Below is the policy JSON you can use to create an IAM user for Terraform with the necessary permissions to create all the resources mentioned.

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iam:GetRole",
        "iam:CreateRole",
        "iam:DeleteRole",
        "iam:AttachRolePolicy",
        "iam:DetachRolePolicy",
        "iam:PassRole",
        "iam:PutRolePolicy",
        "iam:DeleteRolePolicy",
        "iam:ListRolePolicies",
        "iam:ListAttachedRolePolicies",
        "iam:GetRolePolicy"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "lambda:CreateFunction",
        "lambda:DeleteFunction",
        "lambda:GetFunction",
        "lambda:InvokeFunction",
        "lambda:UpdateFunctionCode",
        "lambda:UpdateFunctionConfiguration",
        "lambda:AddPermission",
        "lambda:RemovePermission",
        "lambda:ListVersionsByFunction",
        "lambda:GetFunctionCodeSigningConfig",
        "lambda:GetPolicy",
        "lambda:ListFunctions"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetBucketLocation",
        "s3:GetObject",
        "s3:ListBucketMultipartUploads",
        "s3:ListMultipartUploadParts",
        "s3:ListObjectsV2",
        "s3:PutObject",
        "s3:CreateBucket",
        "s3:DeleteBucket",
        "s3:ListAllMyBuckets"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "events:PutRule",
        "events:DeleteRule",
        "events:DescribeRule",
        "events:ListRules",
        "events:PutTargets",
        "events:RemoveTargets",
        "events:ListTargetsByRule",
        "events:ListTagsForResource"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "cloudwatch:PutMetricData",
        "cloudwatch:GetMetricData",
        "cloudwatch:ListMetrics"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Resource": "*"
    }
  ]
}
```

## Steps to Create the IAM User and Attach the Policy

1 Create the IAM User:

* Go to the IAM Console.
* Click on "Users" and then "Add user".
* Enter a user name (e.g., bucket-costs).
* Select "Programmatic access" for access type.
* Click "Next: Permissions".

2. Attach the Policy:

* On the "Set permissions" page, choose "Attach existing policies directly".
* Click "Create policy".
* Select the "JSON" tab and paste the above JSON policy.
* Review the policy, add tags if needed, and click "Create policy".
* Back on the "Attach permissions" screen, search for your newly created policy.
* Select the policy and click "Next: Tags".
* Add tags if needed and click "Next: Review".
* Review the user and permissions, then click "Create user".

3. Store the Access Credentials:

* After creating the user, download the .csv file with the access key ID and secret access key.
* Use these credentials to configure your Terraform AWS provider.

4. Add Your Credentials to the File:

```
[bucketcosts]
aws_access_key_id = your_terraform_access_key_id
aws_secret_access_key = your_terraform_secret_access_key
```
