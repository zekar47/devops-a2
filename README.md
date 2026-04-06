# 🚀 Proyecto AWS DevOps: Automatización y Despliegue Controlado

## 🎯 Descripción del Proyecto
Este proyecto implementa una solución de automatización en AWS que integra la gestión de instancias EC2 mediante Python (Boto3) y el respaldo de datos en S3 mediante scripts POSIX Shell. El objetivo es simular un flujo de trabajo CI/CD donde la infraestructura y los datos se gestionan de forma programática y segura.

## 🛠️ Requisitos del Entorno
- **AWS CLI**: Configurado con credenciales de Learner Lab.
- **Python 3**: Con la librería `boto3` instalada.
- **GitHub CLI (`gh`)**: Para control de versiones.
- **Direnv (Opcional)**: Para carga automática de variables de entorno.

## 📁 Estructura del Proyecto
- `ec2/gestionar_ec2.py`: Script en Python para listar, iniciar, detener y terminar instancias.
- `s3/backup.sh`: Script en Shell para comprimir directorios y subirlos a S3.
- `config/config.env`: Archivo de configuración (ID de instancia, Bucket, Rutas).
- `logs/`: Directorio que contiene los registros de ejecución.
- `deploy.sh`: Orquestador principal del flujo.

## 🌿 Flujo de Git (Branching)
Se siguió una estrategia de ramas para garantizar la estabilidad del código:
1. `feature/*`: Desarrollo de funcionalidades individuales.
2. `main`: Versión estable y entregable.

## 🚀 Instrucciones de Uso

### 1. Configuración
Edite el archivo `config/config.env` con sus datos de AWS:
```bash
INSTANCE_ID="tu_id_de_instancia"
BUCKET_NAME="tu_nombre_de_bucket"
DIRECTORY="./data"
```

### 2. Ejecución
Otorgue permisos de ejecución a los scripts:
```bash
chmod +x deploy.sh s3/backup.sh
```

**Ejemplos de comandos:**
- Listar instancias: `./deploy.sh listar`
- Iniciar instancia y hacer backup: `./deploy.sh iniciar`
- Detener instancia: `./deploy.sh detener`

## 📊 Validación de Resultados
El sistema genera logs automáticos en la carpeta `/logs`. Un flujo exitoso se ve así:
1. El orquestador llama a `gestionar_ec2.py`.
2. Si la acción es `iniciar`, se dispara `backup.sh`.
3. El archivo comprimido se sube a S3 y se registra en `s3.log`.
