"""Loads badges from XML dump into HDFS

Start pyspark2 with the command below and you can test from the REPL
  pyspark2 --packages com.databricks:spark-xml_2.11:0.4.1,com.databricks:spark-csv_2.11:1.5.0
Or run using
  spark2-submit --packages com.databricks:spark-xml_2.11:0.4.1,com.databricks:spark-csv_2.11:1.5.0 prepare_data_badges_csv.py
Demo for Pluralsight course:
  Developing Spark Applications Using Python and Cloudera
Created by Xavier Morera
"""
import pyspark
import pyspark.sql
from pyspark.sql import SparkSession
import xml.etree.ElementTree as ET
import re
import sys
import time
import datetime
import csv


def set_midnight(thistime):
    if thistime is None:
        return thistime
    wheret = thistime.index('T')
    return thistime[:wheret] + "T00:00:00.000Z"  


# extract the values in each xml row
def processXmlFields(string):
    elements = ET.fromstring(string.encode('utf-8')).attrib
    
    badge_id = elements.get("Id")
    user_id = elements.get("UserId")
    badge_name = elements.get("Name")
    creationdate = set_midnight(elements.get("Date"))
    badge_class = elements.get("Class")
    tag_based = elements.get("TagBased")
    
    return (badge_id, user_id, badge_name, creationdate, badge_class, tag_based)

def main():
    spark = SparkSession.builder.appName("PrepareBadgesCSV").getOrCreate() 
     
    xml_posts = spark.sparkContext.newAPIHadoopFile("/user/cloudera/stackexchange/Badges.xml", 'com.databricks.spark.xml.XmlInputFormat', 'org.apache.hadoop.io.Text', 'org.apache.hadoop.io.Text', conf={'xmlinput.start': '<row', 'xmlinput.end': '/>'})
    each_badge = xml_posts.map(lambda x: x[1])
    badge_fields = each_badge.map(processXmlFields)

    postDF = spark.createDataFrame(badge_fields)

    postDF.write.format('com.databricks.spark.csv').options(header='false').save('/user/cloudera/stackexchange/badges_csv')

if __name__ == "__main__":
    main()
