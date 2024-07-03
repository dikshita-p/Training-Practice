from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("Read-CsvFile").getOrCreate()

file_path = "file3.csv"

df1 = spark.read.option("header", "true").csv(file_path)     #dataframe where inferschema is false.

df1.show()

df1.printSchema()

df = spark.read.option("header", "true").option("inferSchema", "true").csv(file_path)

df.show()

df.printSchema()

row_count = df.count()
print(f"Number of rows: {row_count}")

print(df.head(5))

print(df.tail(1))

spark.stop()