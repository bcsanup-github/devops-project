from flask import Flask
import socket
import os
from datetime import datetime
import psycopg2

app = Flask(__name__)

DB_HOST = os.getenv("DB_HOST", "localhost")
DB_NAME = os.getenv("DB_NAME", "devopsdb")
DB_USER = os.getenv("DB_USER", "postgres")
DB_PASSWORD = os.getenv("DB_PASSWORD", "postgres")

def check_database():
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            database=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD
        )

        cur = conn.cursor()
        cur.execute("SELECT version();")

        db_version = cur.fetchone()

        cur.close()
        conn.close()

        return {
            "database_status": "connected",
            "postgres_version": db_version[0]
        }

    except Exception as e:
        return {
            "database_status": "failed",
            "error": str(e)
        }

@app.route("/")
def home():
    return {
        "message": "DevOps Multi-Container Project Running",
        "hostname": socket.gethostname(),
        "environment": os.getenv("ENVIRONMENT", "development"),
        "time": str(datetime.now()),
        "database": check_database()
    }

@app.route("/health")
def health():
    return {
        "status": "healthy"
    }

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)