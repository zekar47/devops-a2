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

    instancias = list(ec2.instances.all())
    try:
        if accion == "listar":
            if instancias:
                for instance in ec2.instances.all():
                    print(f"ID: {instance.id} | Estado: {instance.state['Name']}")
            else:
                print("No se encontraron instancias EC2")

        elif accion in ["iniciar", "detener", "terminar"]:
            if not instance_id:
                print(f"Error: La acción '{accion}' requiere un ID de instancia.")
                return

            instance = ec2.Instance(instance_id)

            if accion == "iniciar":
                instance.start()
            elif accion == "detener":
                instance.stop()
            elif accion == "terminar":
                instance.terminate()

            print(f"Ejecutando '{accion}' en {instance_id}...")
        else:
            print(f"Acción '{accion}' no reconocida.")

    except ClientError as e:
        print(f"Error de AWS: {e}")


if __name__ == "__main__":
    gestionar()
