from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("Demo").getOrCreate()

data = [1,2,3,4,5,6,7,8,9,10,11,12]
rdd = spark.sparkContext.parallelize(data)

x = rdd.collect()

print(x)



