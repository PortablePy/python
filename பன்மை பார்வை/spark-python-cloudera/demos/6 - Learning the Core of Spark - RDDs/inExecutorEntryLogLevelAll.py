"""Shows how to set log level and run a function that writes in executor

Execute with spark2-submit inExecutorLogLevelAll.py
Demo for Pluralsight course:
  Developing Spark Applications Using Python and Cloudera
Created by Xavier Morera
"""
from pyspark import SparkContext

def inExecutor(entry):
  print "*** inExecutorEntry ***"
  print entry[0]
  print type(entry)
  return "printed: " + str(entry[0])

def main():
    sc = SparkContext().getOrCreate()
    sc.setLogLevel("ALL")

    test_write = sc.parallelize(['xavier', 'troy'])
    test_write.map(lambda x: inExecutor(x)).collect()
    sc.setLogLevel("WARN")

if __name__ == "__main__":
    main()