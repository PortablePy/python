"""Loads tags XML as JSON in HDFS

Start pyspark2 with the command below and you can test from the REPL
  pyspark2 --packages com.databricks:spark-xml_2.11:0.4.1,com.databricks:spark-csv_2.11:1.5.0
Or run using
  spark2-submit --packages com.databricks:spark-xml_2.11:0.4.1,com.databricks:spark-csv_2.11:1.5.0 prepare_data_comments_parquet.py
Demo for Pluralsight course:
  Developing Spark Applications Using Python and Cloudera
Created by Xavier Morera
"""
import pyspark
import pyspark.sql
from pyspark.sql import SparkSession
import xml.etree.ElementTree as ET
import sys
import time
import datetime
import csv


# extract the values in each xml row
def processXmlFields(string):
    elements = ET.fromstring(string.encode('utf-8')).attrib
    
    comment_id = elements.get("Id")
    post_id = elements.get("PostId")
    score = elements.get("Score")
    creation_date = elements.get("CreationDate")
    user_id = elements.get("UserId")
    
    if comment_id is not None: 
        comment_id = int(comment_id)
    if post_id is not None: 
        post_id = int(post_id)        
    if score is not None: 
        score = int(score)        
    creation_date = datetime.datetime.strptime(creation_date[0:creation_date.find('.')],'%Y-%m-%dT%H:%M:%S')
    if user_id is not None: 
        user_id = int(user_id)    
    
    return (comment_id, post_id, score, creation_date, user_id)

def main():
    spark = SparkSession.builder.appName("PrepareCommentsParquet").getOrCreate() 
     
    xml_posts = spark.sparkContext.newAPIHadoopFile("/user/cloudera/stackexchange/Comments.xml", 'com.databricks.spark.xml.XmlInputFormat', 'org.apache.hadoop.io.Text', 'org.apache.hadoop.io.Text', conf={'xmlinput.start': '<row', 'xmlinput.end': '/>'})
    each_comment = xml_posts.map(lambda x: x[1])
    comments_fields = each_comment.map(processXmlFields)

    from pyspark.sql.types import *
    commentsSchema = \
    StructType([
    StructField("Id",IntegerType()),
    StructField("PostId",IntegerType()),
    StructField("Score",IntegerType()),
    StructField("CreationDate",TimestampType()),
    StructField("UserId",IntegerType())])

    postDF = spark.createDataFrame(comments_fields, schema=commentsSchema)

    postDF.write.save('/user/cloudera/stackexchange/comments_parquet')

if __name__ == "__main__":
    main()
