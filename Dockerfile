# Base image
FROM python:3.12-slim
WORKDIR /app

# Install OpenJDK 21 (required for Spark)
RUN apt-get update && \
    apt-get install -y openjdk-21-jre-headless wget curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Install PySpark
RUN pip install --no-cache-dir pyspark==3.5.1 boto3

# Copy your Spark job
COPY . /app

# Default command to run your job
CMD ["python", "bronze_layer.py"]
