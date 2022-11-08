"""Loads tags XML as JSON in HDFS

Start pyspark2 with the command below and you can test from the REPL
  pyspark2 --packages com.databricks:spark-xml_2.11:0.4.1,com.databricks:spark-csv_2.11:1.5.0
Or run using
  spark2-submit --packages com.databricks:spark-xml_2.11:0.4.1,com.databricks:spark-csv_2.11:1.5.0 prepare_data_tags_json.py
Demo for Pluralsight course:
  Developing Spark Applications Using Python and Cloudera
Created by Xavier Morera
"""
import pyspark
import pyspark.sql
from pyspark.sql import SparkSession
from pyspark.sql.types import *
import xml.etree.ElementTree as ET
import re
import sys
import time
import datetime
import csv


# extract the values in each xml row
def processXmlFields(string):
    elements = ET.fromstring(string.encode('utf-8')).attrib
    
    tag_id = elements.get("Id")
    tag_name = elements.get("TagName")
    count = elements.get("Count")
    excerpt_post_id = elements.get("ExcerptPostId")
    wiki_post_id = elements.get("WikiPostId")
       
    return (tag_id, tag_name, count, excerpt_post_id, wiki_post_id)

def main():
    spark = SparkSession.builder.appName("PrepareTagsJson").getOrCreate() 
      
    xml_tags = spark.sparkContext.newAPIHadoopFile("/user/cloudera/stackexchange/Tags.xml", 'com.databricks.spark.xml.XmlInputFormat', 'org.apache.hadoop.io.Text', 'org.apache.hadoop.io.Text', conf={'xmlinput.start': '<row', 'xmlinput.end': '/>'})
    each_tag = xml_tags.map(lambda x: x[1])
    tag_fields = each_tag.map(processXmlFields)
    
    tags_schema = \
    StructType([
    StructField("Id",StringType()),
    StructField("TagName",StringType()),
    StructField("Count",StringType()),
    StructField("ExcerptPostId",StringType()),
    StructField("WikiPostId",StringType())])
    
    tagDF = spark.createDataFrame(tag_fields, tags_schema)
    
    tagDF.write.json('/user/cloudera/stackexchange/tags_json')

if __name__ == "__main__":
    main()
