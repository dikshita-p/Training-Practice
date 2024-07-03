from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("Read-TextFile").getOrCreate()

text_file_path = "Assignment/PySpark/file1.txt"

rdd = spark.sparkContext.textFile(text_file_path)

data = rdd.collect()

print(data)    #prints lines of file in form of list. : ['This is a Sample Text file.', 'This file is readed and a RDD is created.', 'All the operation are done using Spark.']

for line in data:
    print(line)    
  
    
spark.stop()    