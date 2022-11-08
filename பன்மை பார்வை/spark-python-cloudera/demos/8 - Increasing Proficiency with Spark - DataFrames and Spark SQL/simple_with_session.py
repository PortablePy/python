"""Shows a simple application being executed in Python without a session

Run with spark2-submit simple_with_session.py
Demo for Pluralsight course:
  Developing Spark Applications Using Python and Cloudera
Created by Xavier Morera
"""
from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("Simple with Session").master("yarn").getOrCreate()

print "*** Testing simple_with_session.py ***"
print "*** Application name: " + spark.sparkContext.appName + " / Version: " + spark.version + " ***"

spark.stop()