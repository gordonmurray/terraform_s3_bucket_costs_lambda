# terraform_s3_bucket_costs_lambda
A lambda function to list s3 buckets and their size

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