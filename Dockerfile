FROM amazonlinux:2023

# Install dependencies
RUN yum update -y && \
    yum install -y python3 python3-pip java-21-openjdk wget unzip && \
    yum clean all

# Set JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/jre-21
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Install PySpark & AWS Glue libraries
RUN pip3 install --no-cache-dir pyspark==3.4.1 boto3 py4j awsglue-local

# Download AWS Glue 4.0 JAR dependencies
RUN mkdir -p /opt/glue/jars && \
    wget -q https://raw.githubusercontent.com/awslabs/aws-glue-libs/master/jars/glue-assembly.jar -P /opt/glue/jars

# Add Glue path
ENV SPARK_HOME=/usr/lib/spark
ENV GLUE_JARS=/opt/glue/jars/glue-assembly.jar
ENV PYTHONPATH="/opt/glue/python:$PYTHONPATH"

# Copy your Glue script
WORKDIR /app
COPY . /app

CMD ["python3", "main.py"]
