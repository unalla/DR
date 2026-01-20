import json
import boto3
import os
from pinecone import Pinecone
from openai import OpenAI

# Initialize clients outside the handler for better performance
s3 = boto3.client('s3')
pc = Pinecone(api_key=os.environ['PINECONE_API_KEY'])
index = pc.Index("dr-runbooks")
openai_client = OpenAI(api_key=os.environ['OPENAI_API_KEY'])

def lambda_handler(event, context):
    # 1. Get bucket and file info from the S3 event
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']
    
    # 2. Read the file content
    response = s3.get_object(Bucket=bucket, Key=key)
    content = response['Body'].read().decode('utf-8')
    
    # 3. Generate Embedding
    res = openai_client.embeddings.create(
        input=[content],
        model="text-embedding-3-small"
    )
    embedding = res.data[0].embedding
    
    # 4. Upsert to Pinecone
    index.upsert(vectors=[{
        "id": key, # Use the S3 filename as the ID
        "values": embedding,
        "metadata": {"text": content}
    }])
    
    return {"status": "success", "file": key}