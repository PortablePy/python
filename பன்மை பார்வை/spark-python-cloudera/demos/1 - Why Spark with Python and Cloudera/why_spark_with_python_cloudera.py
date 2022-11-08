# Note: not meant to be executed as an application, this file has .py extension for display in a code editor
# *** 1 - Why Spark with Python and Cloudera  ***
# This module provides a quick introduction into why Spark is a top choice for working with Big Data. It then adds into the mix the use of Python as a programming language to use the Spark API and then why Cloudera can make it easier to have an environment to work with

# *****************************************************************************************************
# *****************************************************************************************************
# *** But Why Apache Spark? ***
demos = sc.textFile("/user/cloudera/spark-course/")
demos.flatMap(lambda line: line.split()).map(lambda word: (word, 1)).reduceByKey(lambda a, b: a + b)

