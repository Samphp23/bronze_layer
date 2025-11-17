FROM python:3.12-slim

WORKDIR /app

# Copy everything into container
COPY . /app

RUN apt-get update && \
    apt-get install -y openjdk-21-jre-headless && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

RUN pip install --no-cache-dir pyspark==3.5.1 boto3


# Run correct python file
CMD ["python", "bronze_layer.py"]
