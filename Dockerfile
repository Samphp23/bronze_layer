FROM python:3.10-slim

# Install Java (required for Spark)
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk wget curl && \
    apt-get clean

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Install Python dependencies
RUN pip install pyspark==3.5.0 \
    delta-spark==3.1.0 \
    boto3 \
    awscli \
    psycopg2-binary

# Optional: Install AWS Glue libraries (for GlueContext)
RUN mkdir -p /opt/glue-libs && \
    curl -o /opt/glue-libs/awsglue.zip https://aws-glue-etl-artifacts.s3.amazonaws.com/glue-3.0/python/awsglue.zip && \
    unzip /opt/glue-libs/awsglue.zip -d /opt/glue-libs/

ENV PYTHONPATH=/opt/glue-libs:$PYTHONPATH

# Copy your PySpark script
COPY bronze_layer.py /app/bronze_layer.py
WORKDIR /app

CMD ["python", "bronze_layer.py"]
