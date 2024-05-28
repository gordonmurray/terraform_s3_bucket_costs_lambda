# S3 Bucket costs using Lambda

A lambda function to list S3 buckets and their sizes.

### Permissions

An IAM user is required for Terraform to create this project in the AWS account.

Follow the steps in [Permission Details](permissions.md) to create an IAM user in your AWS account


### Packaging the Lambda Function

Before deploying, you need to package your Lambda function code (lambda_function.py) into a .zip file:

```
zip lambda.zip lambda_function.py
```


### Deploy the Terraform Configuration

```
terraform init
terraform apply
```



### Summary log

A log will be written to an s3 bucket. The output will look something like this:

```
Summary as of 2024-01-01 08:00:00 UTC

Bucket: ec2-webserver-logs-bucket, Size: 23.34 GB, Location: eu-west-1
Bucket: my-test-bucket, Size: 0.29 GB, Location: None
```


### Esimated running costs

Assuming the lambda runs once a month and takes 60 minutues to run:

```
 Name                            Monthly Qty  Unit         Monthly Cost

 aws_lambda_function.s3_summary
 ├─ Requests                          0.0000  1M requests         $0.00  *
 └─ Duration (first 6B)                  450  GB-seconds          $0.01  *

 OVERALL TOTAL                                                    $0.01

*Usage costs were estimated using infracost-usage.yml, see docs for other options.

──────────────────────────────────
6 cloud resources were detected:
∙ 1 was estimated
∙ 5 were free

┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━┓
┃ Project                                            ┃ Baseline cost ┃ Usage cost* ┃ Total cost ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━╋━━━━━━━━━━━━┫
┃ main                                               ┃ $0.00         ┃ $0.01       ┃ $0.01      ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━┛
```