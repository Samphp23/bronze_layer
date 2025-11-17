from pyspark.sql import SparkSession
path_1 = "s3://samir-test-demo-small-data-pipeline/datalake/productions.json"
path_2 = "s3://samir-test-demo-small-data-pipeline/datalake/sales.csv"
prod_destination = "s3://samir-test-demo-small-data-pipeline/bronze_layer/productions_parquet/"
sales_destination = "s3://samir-test-demo-small-data-pipeline/bronze_layer/sales_parquet/"

spark = SparkSession.builder \
    .appName("DataMigrationJob") \
    .getOrCreate()

df = spark.read.format("json").option("multiline", True).option("mode", "PERMISSIVE").load(path_1)
df.coalesce(1).write \
    .mode("overwrite") \
    .parquet(prod_destination)
df1 = spark.read.csv(path_2,header=True,inferSchema=True)
df1.write.mode("overwrite").parquet(sales_destination)



from pyspark.sql import SparkSession
path_1 = "s3://samir-test-demo-small-data-pipeline/datalake/productions.json"
path_2 = "s3://samir-test-demo-small-data-pipeline/datalake/sales.csv"
prod_destination = "s3://samir-test-demo-small-data-pipeline/bronze_layer/productions_parquet/"
sales_destination = "s3://samir-test-demo-small-data-pipeline/bronze_layer/sales_parquet/"

spark = SparkSession.builder \
    .appName("DataMigrationJob") \
    .getOrCreate()

df = spark.read.format("json").option("multiline", True).option("mode", "PERMISSIVE").load(path_1)
df.write \
    .mode("overwrite") \
    .parquet(prod_destination)
df1 = spark.read.csv(path_2,header=True,inferSchema=True)
df1.write.mode("overwrite").parquet(sales_destination)