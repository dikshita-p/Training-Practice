import pyspark
from pyspark.sql import SparkSession

print("pyspark setup successfully ")
spark = SparkSession.builder.appName("Test").getOrCreate()
print(spark.version , "Hello")

