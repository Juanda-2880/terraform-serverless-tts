import json
import os
import boto3
import uuid
from contextlib import closing

polly_client = boto3.client('polly')
s3_client = boto3.client('s3')

def lambda_handler(event, context):
    """
    Función principal que recibe el texto, lo convierte a audio y lo guarda en S3.
    """
    try:
        text_to_convert = event.get('text', 'Hola mundo, esta es una prueba de AWS Polly con Terraform.')
        bucket_name = os.environ['BUCKET_NAME']
        file_name = f"audio-{str(uuid.uuid4())}.mp3"
        print(f"Iniciando síntesis para: {file_name}")

        response = polly_client.synthesize_speech(
            Text=text_to_convert,
            OutputFormat='mp3',
            VoiceId='Lucia', 
            Engine='neural'  
        )

        if "AudioStream" in response:
            with closing(response["AudioStream"]) as stream:
                s3_client.put_object(
                    Bucket=bucket_name,
                    Key=file_name,
                    Body=stream.read(),
                    ContentType='audio/mpeg'
                )
        
        print(f"Éxito! Archivo guardado en: s3://{bucket_name}/{file_name}")
        
        return {
            'statusCode': 200,
            'body': json.dumps({
                'message': 'Conversión exitosa',
                'file_name': file_name,
                'bucket': bucket_name,
                's3_uri': f"s3://{bucket_name}/{file_name}"
            })
        }

    except Exception as e:
        print(f"Error: {str(e)}")
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }