import os
from pinecone import Pinecone
from dotenv import load_dotenv
import openai

# Set up clients
load_dotenv()
pc = Pinecone(api_key=os.getenv("PINECONE_API_KEY"))
index = pc.Index("dr-runbooks")

def index_runbook(text, doc_name):
    # Create vector embedding
    res = openai.Embedding.create(input=text, model="text-embedding-3-small")
    vector = res['data'][0]['embedding']
    
    # Upload to Pinecone
    index.upsert(vectors=[{"id": doc_name, "values": vector, "metadata": {"content": text}}])

# Example Usage
index_runbook("Step 1: If primary fails, re-associate EIP...", "failover_guide")