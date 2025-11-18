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

# Copy your script into the container
COPY script.py /app/script.py

# Set working directory
WORKDIR /app

# Default command to run your script
CMD ["python", "script.py"]
