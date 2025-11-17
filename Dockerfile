FROM python:3.12-slim
RUN apt-get update && \
    apt-get install -y openjdk-17-jre-headless && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"
RUN pip install --no-cache-dir pyspark==3.5.1
COPY bronze_layer.py /app/bronze_layer.py
WORKDIR /app
CMD ["python", "datamigration.py"]
