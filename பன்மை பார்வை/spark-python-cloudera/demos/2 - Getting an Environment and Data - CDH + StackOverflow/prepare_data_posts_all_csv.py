"""Loads posts from XML into HDFS

Start pyspark2 with the command below and you can test from the REPL
  pyspark2 --packages com.databricks:spark-xml_2.11:0.4.1,com.databricks:spark-csv_2.11:1.5.0
Or run using
  spark2-submit --packages com.databricks:spark-xml_2.11:0.4.1,com.databricks:spark-csv_2.11:1.5.0 prepare_data_posts_all_csv.py
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
    
    postId = elements.get("Id")
    postType = elements.get("PostTypeId")
    acceptedanswerid = elements.get("AcceptedAnswerId")
    creationdate = elements.get("CreationDate")
    score = elements.get("Score")
    viewCount = elements.get("ViewCount")
    #Body - not included
    owneruserid = elements.get("OwnerUserId")
    lasteditoruserid = elements.get("LastEditorUserId")
    lasteditdate = elements.get("LastEditDate")
    title = elements.get("Title")
    lastactivitydate = elements.get("LastActivityDate")
    tags = re.findall(r'[\w.-]+', elements.get("Tags", ""))
    answercount = elements.get("AnswerCount")
    commentcount = elements.get("CommentCount")
    favoritecount = elements.get("FavoriteCount")
    
    if lasteditdate == None:
        lasteditdate = creationdate
    
    return (postId, postType, acceptedanswerid, creationdate, score, viewCount, owneruserid, lasteditoruserid, lasteditdate, title, lastactivitydate, tags, answercount, commentcount, favoritecount)

def main():
    spark = SparkSession.builder.appName("PreparePostsCSV").getOrCreate() 
     
    xml_posts = spark.sparkContext.newAPIHadoopFile("/user/cloudera/stackexchange/Posts.xml", 'com.databricks.spark.xml.XmlInputFormat', 'org.apache.hadoop.io.Text', 'org.apache.hadoop.io.Text', conf={'xmlinput.start': '<row', 'xmlinput.end': '/>'})
    each_post = xml_posts.map(lambda x: x[1])
    post_fields = each_post.map(processXmlFields)
    
    from pyspark.sql.types import *
    questionsSchema = \
    StructType([
    StructField("Id",StringType()),
    StructField("PostTypeId",StringType()),
    StructField("AcceptedAnswerId",StringType()),
    StructField("CreationDate",StringType()),
    StructField("Score",StringType()),
    StructField("ViewCount",StringType()),
    StructField("OwnerUserId",StringType()),
    StructField("LastEditorUserId",StringType()),
    StructField("LastEditDate",StringType()),
    StructField("Title",StringType()),
    StructField("LastActivityDate",StringType()),
    StructField("Tags",StringType()),
    StructField("AnswerCount",StringType()),
    StructField("CommentCount",StringType()),
    StructField("FavoriteCount",StringType())])

    postDF = spark.createDataFrame(post_fields, questionsSchema)

    postDF.write.format('com.databricks.spark.csv').options(header='false').save('/user/cloudera/stackexchange/posts_all_csv')

if __name__ == "__main__":
    main()
