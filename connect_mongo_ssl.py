import os
from urllib.parse import quote_plus
from pymongo import MongoClient
from pymongo.errors import PyMongoError

# SSL certificate files
cert_file = (
    os.path.dirname(__file__) + "/ssl/server.pem"
)  # Path to the certificate file
ca_file = (
    os.path.dirname(__file__) + "/ssl/server.pem"
)  # Path to the CA file (self-signed cert)

try:
    # Create a MongoClient with SSL enabled
    client = MongoClient(
        f"mongodb://admin:password@localhost:27017?tls=true&tlsCertificateKeyFile={quote_plus(cert_file)}&tlsCAFile={ca_file}",
        # tls=True,
        # tlsCertificateKeyFile=cert_file,
        # tlsCAFile=ca_file,
    )

    # Test the connection
    db = client.admin
    print("Connected to MongoDB with SSL")
    print("MongoDB version:", db.command("buildinfo")["version"])
except PyMongoError as e:
    print("Failed to connect to MongoDB:", e)
