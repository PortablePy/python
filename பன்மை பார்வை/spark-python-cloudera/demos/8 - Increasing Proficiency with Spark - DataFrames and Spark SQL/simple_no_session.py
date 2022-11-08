"""Shows a simple application being executed in Python without a session

Run with spark2-submit simple_no_session.py
Demo for Pluralsight course:
  Developing Spark Applications Using Python and Cloudera
Created by Xavier Morera
"""
print "Testing simple_no_session.py"
print "Application name: " + spark.sparkContext.appName + " / Version: " + spark.version 

spark.stop()