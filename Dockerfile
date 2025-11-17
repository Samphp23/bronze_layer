FROM python:3.12-slim

WORKDIR /app

# Install Java for Spark
RUN apt-get update && \
    apt-get install -y openjdk-17-jre-headless && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Install PySpark + boto3
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy ETL script
COPY bronze_layer.py /app/

# Run ETL
CMD ["python", "bronze_layer.py"]
