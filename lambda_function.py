import boto3
from datetime import datetime

def lambda_handler(event, context):
    s3_client = boto3.client('s3')
    s3_resource = boto3.resource('s3')

    # List all S3 buckets
    response = s3_client.list_buckets()
    buckets = response['Buckets']

    summary_lines = []

    # Calculate the size of each bucket
    for bucket in buckets:
        bucket_name = bucket['Name']
        bucket_size = 0
        bucket_location = s3_client.get_bucket_location(Bucket=bucket_name)['LocationConstraint']

        # Sum the size of all objects in the bucket
        for obj in s3_resource.Bucket(bucket_name).objects.all():
            bucket_size += obj.size

        summary_line = f"Bucket: {bucket_name}, Size: {bucket_size / (1024 ** 3):.2f} GB, Location: {bucket_location}"
        summary_lines.append(summary_line)

    # Create summary text
    summary_text = "\n".join(summary_lines)
    summary_text = f"Summary as of {datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S UTC')}\n\n" + summary_text

    # Save the summary to an S3 bucket
    output_bucket = "bucket-cost-logs"  # Ensure this matches the environment variable set in Terraform
    current_time = datetime.utcnow().strftime('%Y-%m-%d_%H:%M')
    output_key = f"s3-bucket-costs-{current_time}.txt"

    s3_client.put_object(Bucket=output_bucket, Key=output_key, Body=summary_text)

    return {
        'statusCode': 200,
        'body': 'Summary created and uploaded successfully.'
    }
