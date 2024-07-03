from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("Read-JsonFile").getOrCreate()

file_path = "file2.json"

df = spark.read.option("multiline", "true").json(file_path)

df.show()

df.printSchema()

row_count = df.count()
print(f"Number of rows: {row_count}")

print(df.head())

print(df.tail(2))

df.describe().show()

spark.stop()