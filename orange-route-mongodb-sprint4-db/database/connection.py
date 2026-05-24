from pymongo import MongoClient

# Conexão local MongoDB
client = MongoClient("mongodb://localhost:27017/")

# Database
db = client["orange_route"]

print("MongoDB conectado com sucesso!")