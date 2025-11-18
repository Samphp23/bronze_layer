# -------------------------------
# Base image with Python 3.10 slim
# -------------------------------
FROM python:3.10-slim

# -------------------------------
# Environment variables
# -------------------------------
ENV PYSPARK_PYTHON=python3
ENV PYTHONUNBUFFERED=1
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH
ENV PYTHONPATH=/opt/awsglue:$PYTHONPATH

# -------------------------------
# Install system dependencies
# -------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-11-jdk-headless \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# -------------------------------
# Install Python dependencies
# -------------------------------
RUN pip install --upgrade pip && \
    pip install --no-cache-dir \
        boto3 \
        pandas \
        pyarrow \
        awscli \
        pyspark==3.4.1

# -------------------------------
# Install AWS Glue Python libraries
# -------------------------------
RUN curl -O https://aws-glue-etl-artifacts.s3.amazonaws.com/glue-3.0/python/lib/awsglue.zip && \
    unzip awsglue.zip -d /opt/awsglue && \
    rm awsglue.zip

# -------------------------------
# Copy your Glue script
# -------------------------------
WORKDIR /app
COPY bronze_layer.py /app/bronze_layer.py

# -------------------------------
# Command to run Glue script
# -------------------------------
CMD ["python", "bronze_layer.py"]
