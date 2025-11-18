FROM apache/spark-py:latest

# Install boto3
USER root
RUN pip install boto3

# Copy your script
COPY bronze_layer.py /opt/spark/work-dir/bronze_layer.py

# Set working directory
WORKDIR /opt/spark/work-dir

# Run your script
CMD ["python3", "bronze_layer.py"]
