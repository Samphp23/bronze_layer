from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

sc = SparkContext.getOrCreate()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)

# S3 paths
sales_path = "s3://samir-test-demo-small-data-pipeline/datalake/sales.csv"
production_path = "s3://samir-test-demo-small-data-pipeline/datalake/productions.json"
sales_dest = "s3://samir-test-demo-small-data-pipeline/bronze_layer/sales_parquet/"
prod_dest = "s3://samir-test-demo-small-data-pipeline/bronze_layer/productions_parquet/"

# Read CSV
df_sales = spark.read.csv(sales_path, header=True, inferSchema=True, mode="PERMISSIVE")
# Read JSON
df_productions = spark.read.json(production_path, multiLine=True, mode="PERMISSIVE")

# Write Parquet
df_sales.write.mode("overwrite").parquet(sales_dest)
df_productions.write.mode("overwrite").parquet(prod_dest)

# Stop Spark session
spark.stop()




