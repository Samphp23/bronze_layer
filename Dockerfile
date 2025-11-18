FROM python:3.10-slim

# Install Java and dependencies
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk wget curl && \
    apt-get clean

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Install PySpark and Hadoop AWS connector
RUN pip install pyspark==3.5.0 boto3

# Add Hadoop AWS JARs for S3 support
ENV SPARK_HOME=/opt/spark
RUN mkdir -p $SPARK_HOME/jars && \
    wget -P $SPARK_HOME/jars https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.4/hadoop-aws-3.3.4.jar && \
    wget -P $SPARK_HOME/jars https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.262/aws-java-sdk-bundle-1.12.262.jar

# Copy your script
COPY bronze_layer.py /app/bronze_layer.py
WORKDIR /app

CMD ["python", "bronze_layer.py"]
