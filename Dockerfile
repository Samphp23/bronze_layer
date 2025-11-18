FROM jupyter/pyspark-notebook:x86_64-ubuntu-22.04

USER root

# Install boto3 if needed
RUN pip install boto3

# Add Hadoop AWS + AWS Java SDK for S3 support
RUN curl -o /usr/local/spark/jars/hadoop-aws-3.3.4.jar https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.4/hadoop-aws-3.3.4.jar \
    && curl -o /usr/local/spark/jars/aws-java-sdk-bundle-1.12.262.jar https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.262/aws-java-sdk-bundle-1.12.262.jar

# Copy your ETL script
COPY bronze_layer.py /home/jovyan/bronze_layer.py

WORKDIR /home/jovyan

# Run your script
CMD ["python3", "bronze_layer.py"]
