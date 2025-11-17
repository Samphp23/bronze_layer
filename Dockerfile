FROM python:3.12-slim
WORKDIR /app

# Install OpenJDK (required for Spark)
RUN apt-get update && \
    apt-get install -y openjdk-21-jre-headless wget curl procps && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Install PySpark + boto3
RUN pip install --no-cache-dir pyspark==3.5.1 boto3

# Enable S3 support
ENV PYSPARK_SUBMIT_ARGS="--packages org.apache.hadoop:hadoop-aws:3.3.6 pyspark-shell"

# Copy your Spark job
COPY . /app

CMD ["python", "bronze_layer.py"]
