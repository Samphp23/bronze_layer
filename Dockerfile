FROM openjdk:11-slim

# Install Python and dependencies
RUN apt-get update && apt-get install -y python3 python3-pip curl && \
    apt-get clean

# Install PySpark
RUN pip3 install pyspark==3.4.1

# Add Hadoop AWS libs for S3 support
RUN curl -L -o /opt/hadoop-aws.jar https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.4/hadoop-aws-3.3.4.jar && \
    curl -L -o /opt/aws-java-sdk-bundle.jar https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.262/aws-java-sdk-bundle-1.12.262.jar

# Set Spark / Hadoop environment variables
ENV PYSPARK_PYTHON=python3
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Copy your code
WORKDIR /app
COPY bronze_layer.py .

# Run script
CMD ["python3", "bronze_layer.py"]
