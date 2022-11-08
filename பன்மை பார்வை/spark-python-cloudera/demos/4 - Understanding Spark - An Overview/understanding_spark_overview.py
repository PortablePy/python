# Note: not meant to be executed as an application, this file has .py extension for display in a code editor
# *** m4 Understanding Spark: An Overview ***
# In this module we will learn about how Spark works, not yet getting too much into programming. Instead we will understand what happens at a high level


# *****************************************************************************************************
# *****************************************************************************************************
# *** Spark, Word Count, Operations and Transformations
# Some SQL statements
# select count(*) from posts
# select distinct(tag) from posts


# *****************************************************************************************************
# *****************************************************************************************************
# *** A Few Words on Fine Grained Transformations and Scalability
# A sample in SQL
# Update Posts set Tags = '[apache-spark,sql]' where PostId=1


# *****************************************************************************************************
# *****************************************************************************************************
# *** Word Count in "Not Big Data"
# This is used to tease on using C#
# using System.Collections.Concurrent;
# ConcurrentDictionary<string, int> words;


# *****************************************************************************************************
# *****************************************************************************************************
# *** How Word Count Works, Featuring Coarse Grained Transformations

lines = sc.textFile('file:///se/simple_titles.txt')
words = lines.flatMap(lambda line: line.split(' '))
word_for_count = words.map(lambda x: (x,1))
word_for_count.reduceByKey(lambda x,y: x + y).collect()

sc.textFile('file:///se/simple_titles.txt'). flatMap(lambda line: line.split(' ')) .map(lambda x: (x,1)).reduceByKey(lambda x,y: x + y).collect()


# *****************************************************************************************************
# *****************************************************************************************************
# *** Lazy Execution, Lineage, Directed Acyclic Graph (DAG) and Fault Tolerance
lines = sc.textFile('file:///se/simple_titles.txt')
words = lines.flatMap(lambda line: line.split(' '))
word_for_count = words.map(lambda x: (x,1))
word_for_count.reduceByKey(lambda x,y: x + y).collect()