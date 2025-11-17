%idle_timeout 900
%glue_version 5.0
%worker_type G.1X
%number_of_workers 2

import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
  
sc = SparkContext.getOrCreate()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
#########################################################################################
sales_path = "s3://samir-test-demo-small-data-pipeline/datalake/sales.csv"
production_path = "s3://samir-test-demo-small-data-pipeline/datalake/productions.json"
############################################################################################
df_sales = spark.read.format('csv').option('header', True).option('inferSchema', True).option('mode', 'PERMISSIVE').load(sales_path)
df_productions = spark.read.format('json').option('multiline', True).load(production_path)

df_sales.write.format('parquet').mode('overwrite').save('s3://samir-test-demo-small-data-pipeline/datalake/sales.parquet')
df_productions.write.format('parquet').mode('overwrite').save('s3://samir-test-demo-small-data-pipeline/datalake/productions.parquet')
