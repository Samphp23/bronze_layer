FROM jupyter/pyspark-notebook:x86_64-ubuntu-22.04

USER root

# Install boto3 safely (do NOT use system pip)
RUN /opt/conda/bin/pip install boto3

# Add Hadoop AWS + AWS Java SDK in correct path
RUN curl -L -o /usr/local/spark/jars/hadoop-aws.jar \
    https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.4/hadoop-aws-3.3.4.jar && \
    curl -L -o /usr/local/spark/jars/aws-java-sdk-bundle.jar \
    https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.262/aws-java-sdk-bundle-1.12.262.jar

# Use the Python that contains pyspark
ENV PYSPARK_PYTHON=/opt/conda/bin/python
ENV PYSPARK_DRIVER_PYTHON=/opt/conda/bin/python

USER jovyan

COPY bronze_layer.py /home/jovyan/bronze_layer.py

WORKDIR /home/jovyan

CMD ["/opt/conda/bin/python", "bronze_layer.py"]

