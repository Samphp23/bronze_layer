# Base image with PySpark
FROM apache/spark-py:latest

# Install required Python packages
RUN pip install --upgrade pip && \
    pip install \
        delta-spark \
        boto3 \
        pandas \
        pyarrow \
        awswrangler

# Copy your bronze_layer into the container
COPY bronze_layer.py /app/bronze_layer.py

# Set working directory
WORKDIR /app

# Default command to run your bronze_layer
CMD ["python", "bronze_layer.py"]

