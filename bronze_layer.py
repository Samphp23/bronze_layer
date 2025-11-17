from pyspark.sql import SparkSession
path_1 = s3samir-test-demo-small-data-pipelinedatalakeproductions.json
path_2 = s3samir-test-demo-small-data-pipelinedatalakesales.csv
prod_destination = s3samir-test-demo-small-data-pipelinebronze_layerproductions_parquet
sales_destination = s3samir-test-demo-small-data-pipelinebronze_layersales_parquet

spark = SparkSession.builder 
    .appName(DataMigrationJob) 
    .getOrCreate()

df = spark.read.format(json).option(multiline, True).option(mode, PERMISSIVE).load(path_1)
df.coalesce(1).write 
    .mode(overwrite) 
    .parquet(prod_destination)
df1 = spark.read.csv(path_2,header=True,inferSchema=True)
df1.coalesce(1).write.mode(overwrite).parquet(sales_destination)