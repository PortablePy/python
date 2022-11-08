"""This application is used to test cluster deployment mode

Run with
spark2-submit --master yarn --deploy-mode cluster count_entries_cluster_mode.py
Demo for Pluralsight course:
  Developing Spark Applications Using Python and Cloudera
Created by Xavier Morera
"""

from pyspark import SparkConf, SparkContext
conf = (SparkConf()         
         .setAppName("ClusterMode"))
sc = SparkContext(conf = conf)  

def main():
    all_posts = sc.textFile("/user/cloudera/stackexchange/Posts.xml")
    total_posts = all_posts.count()
    total_to_write = sc.parallelize(["Total posts found:",total_posts])
    total_to_write.coalesce(1).saveAsTextFile("/user/cloudera/stackexchange/count_cluster_mode/")


if __name__ == "__main__":
    main()
