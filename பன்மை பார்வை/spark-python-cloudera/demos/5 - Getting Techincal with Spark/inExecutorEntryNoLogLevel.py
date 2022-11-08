"""Used for demonstrating log level

Execute with
  spark2-submit inExecutorNoLogLevel.py
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
    sc = SparkContext()    

    test_write = sc.parallelize(['xavier', 'troy'])
    test_write.map(lambda x: inExecutor(x)).collect()

if __name__ == "__main__":
    main()