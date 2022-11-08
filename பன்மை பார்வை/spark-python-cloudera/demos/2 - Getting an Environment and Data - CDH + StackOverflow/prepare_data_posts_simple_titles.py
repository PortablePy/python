"""Loads posts titles from XML into HDFS

Start pyspark2 with the command below and you can test from the REPL
  pyspark2 --packages com.databricks:spark-xml_2.11:0.4.1 
Or run using
  spark2-submit --packages com.databricks:spark-xml_2.11:0.4.1 prepare_data_posts_simple_titles.py
Demo for Pluralsight course:
  Developing Spark Applications Using Python and Cloudera
Created by Xavier Morera
"""

# import pyspark
from pyspark import SparkContext
import xml.etree.ElementTree as ET
import re
import sys
import time
import datetime
import csv


# extract the values in each xml row
def processXmlFields(row):
    elements = ET.fromstring(row.encode('utf-8')).attrib
    
    title = elements.get("Title")
    if title is not None: 
        title = title.replace('?',' ?')    
    
    return (title)


def main():
    sc = SparkContext("yarn", "Simple Titles")
    
    xml_posts = sc.newAPIHadoopFile("/user/cloudera/stackexchange/Posts.xml", 'com.databricks.spark.xml.XmlInputFormat', 'org.apache.hadoop.io.Text', 'org.apache.hadoop.io.Text', conf={'xmlinput.start': '<row', 'xmlinput.end': '/>'})
    each_post = xml_posts.map(lambda x: x[1])
    post_fields = each_post.map(processXmlFields).filter(lambda x: x is not None)
    post_fields.saveAsTextFile('/user/cloudera/stackexchange/simple_titles_txt')

if __name__ == "__main__":
    main()
