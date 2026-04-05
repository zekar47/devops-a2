#!/usr/bin/env python3
import boto3
from botocore.exceptions import ClientError


def list_instances():
    """Simple function to list EC2 instances in the account."""
    # We initialize the EC2 resource (higher-level API than 'client')
    ec2 = boto3.resource("ec2")

    print("--- Listing EC2 Instances ---")

    try:
        # This returns an iterator of instance objects
        for instance in ec2.instances.all():
            print(
                f"ID: {instance.id} | State: {instance.state['Name']} | Type: {instance.instance_type}"
            )

    except ClientError as e:
        print(f"Error connecting to AWS: {e}")


if __name__ == "__main__":
    list_instances()
