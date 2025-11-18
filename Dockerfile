FROM python:3.10-slim

# Set environment variables
ENV PYSPARK_PYTHON=python3
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    curl \
    unzip \
    && apt-get clean

# Set JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Install Python packages as root (avoid user install issues)
RUN pip install --no-cache-dir \
    delta-spark \
    boto3 \
    pandas \
    pyarrow \
    awswrangler

# Optional: Add AWS Glue libraries
RUN curl -O https://aws-glue-etl-artifacts.s3.amazonaws.com/glue-3.0/python/lib/awsglue.zip && \
    unzip awsglue.zip -d /opt/awsglue && \
    rm awsglue.zip

ENV PYTHONPATH="/opt/awsglue:$PYTHONPATH"

# Copy your script
COPY bronze_layer.py /app/bronze_layer.py
WORKDIR /app

CMD ["python", "bronze_layer.py"]
