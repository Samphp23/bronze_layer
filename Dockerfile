# Dockerfile
FROM python:3.9-slim

# Install Java and required system packages for PySpark
RUN apt-get update && \
    apt-get install -y openjdk-17-jre-headless curl build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PySpark (choose version compatible with Java/Python)
RUN pip install --no-cache-dir pyspark==3.3.2

# Copy your Spark app
WORKDIR /app
COPY bronze_layer.py /app/bronze_layer.py

# Default command runs your script (you can override to get pyspark shell)
CMD ["python", "bronze_layer.py"]
