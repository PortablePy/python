"""This application is used to test client deployment mode

Run with
spark2-submit --master yarn --deploy-mode client count_entries_client_mode.py
Demo for Pluralsight course:
  Developing Spark Applications Using Python and Cloudera
Created by Xavier Morera
"""

from pyspark import SparkConf, SparkContext
conf = (SparkConf()         
         .setAppName("ClientMode"))
sc = SparkContext(conf = conf)  

def main():
    all_posts = sc.textFile("/user/cloudera/stackexchange/Posts.xml")
    total_posts = all_posts.count()
    total_to_write = sc.parallelize(["Total posts found:",total_posts])
    total_to_write.coalesce(1).saveAsTextFile("/user/cloudera/stackexchange/count_client_mode/")


if __name__ == "__main__":
    main()
