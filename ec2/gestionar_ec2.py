#!/usr/bin/env python3
import sys

import boto3
from botocore.exceptions import ClientError


def gestionar():
    ec2 = boto3.resource("ec2")
    accion = ""

    # Check if the user provided an action (listar, iniciar, etc.)
    if len(sys.argv) < 2:
        accion = "listar"
    else:
        accion = sys.argv[1].lower()
        instance_id = sys.argv[2] if len(sys.argv) > 2 else None

    try:
        if accion == "listar":
            for instance in ec2.instances.all():
                print(f"ID: {instance.id} | Estado: {instance.state['Name']}")

        # Placeholder for future actions
        else:
            print(f"Acción '{accion}' no reconocida.")
            print("Uso: ./gestionar_ec2.py <accion> [instance_id]")

    except ClientError as e:
        print(f"Error de AWS: {e}")


if __name__ == "__main__":
    gestionar()
