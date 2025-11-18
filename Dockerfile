FROM apache/spark-py:latest

# Copy your script into Spark work directory
COPY bronze_layer.py /opt/spark/work-dir/bronze_layer.py

# Switch to Spark working directory
WORKDIR /opt/spark/work-dir

# Run your PySpark script
CMD ["python3", "bronze_layer.py"]
