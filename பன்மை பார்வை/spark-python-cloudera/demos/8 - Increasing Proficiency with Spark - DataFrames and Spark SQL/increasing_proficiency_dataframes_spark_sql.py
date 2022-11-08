# Note: not meant to be executed as an application, this file has .py extension for display in a code editor
# *** m8 Increasing Proficiency with Spark: DataFrames & Spark SQL ***
# This module covers DataFrames and Spark SQL
# *****************************************************************************************************
# *****************************************************************************************************
# *** SparkSession: The Entry Point to the Spark SQL / DataFrame API ***

spark=SparkSession.builder \
      .master('yarn') \
      .appName('StackOverflowTest') \ 
      .config('spark.executor.memory', '2g') \ 
      .getOrCreate()

pyspark2
spark

# Test both from terminal
cat simple_with_session.pyspark
spark2-submit simple_with_session.py

cat simple_no_session.pyspark
spark2-submit simple_no_session.py

# Create a new session from pyspark
spark
spark_two=spark.newSession()
spark_two


# *****************************************************************************************************
# *****************************************************************************************************
# *** Creating and Loading DataFrames - Including Schemas***
# Create a dataframe manually, from a list
qa_listDF = spark.createDataFrame([(1,'Xavier'),(2,'Irene'),(3,'Xavier')])
type(qa_listDF)
qa_listDF

# Remember collect? You can use to return data to the Driver program
qa_listDF.collect()
sc.parallelize([(1,'Xavier'),(2,'Irene',(3,'Xavier')]).collect()

# You can also do from dictionary
qa_dictDF = spark.createDataFrame({(1,'Xavier'),(2,'Irene'),(3,'Xavier')})
qa_dictDF.collect()

# Row object can be used, you need to import it
from pyspark.sql import Row

# And of course, a Row object
qa_from_row = spark.createDataFrame([Row(1,'Xavier'), Row(2, 'Irene'),(3,'Xavier')])
qa_from_row.collect()

# Collect works, but there is a better way
qa_listDF.collect()
qa_listDF.take(3)
qa_listDF.show()
qa_listDF.show(1)

# More options for returning data to the driver
dir(qa_listDF)
qa_listDF.limit(1)
qa_listDF.limit(1).show()
qa_listDF.head()
qa_listDF.first()
qa_listDF.take(1)
qa_listDF.sample(False, .3, 42).collect()

# Nicer column names
qa_listDF.show()
qaDF = qa_listDF.toDF('Id','QA')
qaDF.show()


# *****************************************************************************************************
# *****************************************************************************************************
# *** DataFrames to RDDs and Viceversa ***
qa_rdd = sc.parallelize([(1,'Xavier'),(2,'Irene',(3,'Xavier')])
qa_rdd
qa_with_ToDF = qa_rdd.toDF()
qa_with_ToDF
qa_with_create = spark.createDataFrame(qa_rdd)
qa_with_create
qa_rdd.collect()
qa_with_ToDF.show()
qa_with_ToDF.rdd.collect()
qa_with_ToDF.rdd.map(lambda x: (x['_1'], x['_2'])).collect()

# And now back to DataFrame, we can check the schema and see that we have an array
badges_columns_rdd.take(3)
badges_from_rddDF = badges_columns_rdd.toDF()
badges_from_rddDF.show(4)


# This runs in terminal first, then inside mysql
# mysql -u root -p
# show databases;
# use scm;
# show tables;
# Select PRODUCT, VERSION FROM PARCELS;

badges_from_rddDF.printSchema()


# *****************************************************************************************************
# *****************************************************************************************************
# ***Loading DataFrames: Text and CSV***
posts_no_schemaTxtDF=spark.read .format('text').load('/user/cloudera/stackexchange/posts_all_csv')
posts_no_schemaTxtDF.printSchema()
posts_no_schemaTxtDF.show(5)
posts_no_schemaTxtDF.show(5, truncate=False)
posts_no_schemaTxtDF.show(100, truncate=False)

# Specifying Format
posts_no_schemaTxtDF=spark.read.text('/user/cloudera/stackexchange/posts_all_csv')
posts_no_schemaTxtDF.show(2)
posts_no_schemaTxtDF.show(2)

# Read csv
posts_no_schemaCSV=spark.read.csv('/user/cloudera/stackexchange/posts_all_csv')
posts_no_schemaCSV.show(5)
posts_no_schemaCSV.printSchema()


# *****************************************************************************************************
# *****************************************************************************************************
# ***Schemas: Inferred and Programatically Specified + Option ***
# You can ask Spark to infer the schema
posts_inferred = spark.read.csv('/user/cloudera/stackexchange/posts_all_csv', inferSchema=True)
posts_inferred.printSchema()

an_rdd = sc.textFile('/thisdoesnotexist')
a_df = spark.read.text('/thisdoesnotexist')

# There are multiple ways of loading the data
posts_inferred = spark.read.csv('/user/cloudera/stackexchange/posts_all_csv', inferSchema=True)
spark.read.csv('/user/cloudera/stackexchange/posts_all_csv')printSchema()
spark.read.csv('/user/cloudera/stackexchange/posts_all_csv', inferSchema=True).printSchema()

# Option to specify infer schema
spark.read.option('inferSchema',True).csv('/user/cloudera/stackexchange/posts_all_csv').printSchema()
spark.read.option('inferSchema',True).option('sep','|').csv('/user/cloudera/stackexchange/posts_all_csv').printSchema()
spark.read.options(inferSchema=True,sep='|').csv('/user/cloudera/stackexchange/posts_all_csv').printSchema()

# Let's now get column names
posts_headersDF = spark.read.option("inferSchema", "true").option('header', True).csv('/user/cloudera/stackexchange/posts_all_csv_with_header')
posts_headersDF.printSchema()
posts_headersDF.show(5)

# Or directly create the schema
from pyspark.sql.types import *

# Correct
postsSchema = \
  StructType([
              StructField("Id", IntegerType()),
              StructField("PostTypeId", IntegerType()),
              StructField("AcceptedAnswerId", IntegerType()),
              StructField("CreationDate", TimestampType()),
              StructField("Score", IntegerType()),
              StructField("ViewCount", IntegerType()),
              StructField("OwnerUserId", IntegerType()),
              StructField("LastEditorUserId", IntegerType()),
              StructField("LastEditDate", TimestampType()),
              StructField("Title", StringType()),
              StructField("LastActivityDate", TimestampType()),              
              StructField("Tags", StringType()),
              StructField("AnswerCount", IntegerType()),
              StructField("CommentCount", IntegerType()),
              StructField("FavoriteCount", IntegerType())])

postsDF = spark.read.schema(postsSchema).csv('/user/cloudera/stackexchange/posts_all_csv')
postsDF.printSchema()
postsDF.schema
postsDF.dtypes
postsDF.columns

# *****************************************************************************************************
# *****************************************************************************************************
# *** More Data Loading: Parquet and JSON ***

default_formatDF = spark.read.load('/user/cloudera/stackexchange/posts_all_csv')

# Loading Parquet
comments_parquetDF = spark.read.parquet('/user/cloudera/stackexchange/comments_parquet')
comments_parquetDF.printSchema()
comments_parquetDF.show()

# Loading JSON
tags_jsonDF = spark.read.json('/user/cloudera/stackexchange/tags_json')
tags_jsonDF.printSchema()
comments_parquetDF.show(5)


# *****************************************************************************************************
# *****************************************************************************************************
# *** Rows, Columns, Expressions and Operators ***

# Let's inspect one row
postsDF.take(1)
postsDF.show(1)


# *****************************************************************************************************
# *****************************************************************************************************
# *** Working with Columns ***

# Refer to columns
postsDF['Title']
postsDF['title']
postsDF.Title
postsDF.title

# And we can return the values in those columns
postsDF.select(postsDF.Title).show(1)
postsDF.select(postsDF['Title']).show(1)
postsDF.select('Title').show()

# Specify multiple columns
postsDF.select('Title', postsDF['Id'], postsDF.CreationDate).show(1)

# Specify a function or do some math
postsDF.select(postsDF.Title, postsDF.Score * 1000, postsDF.Score).show(1)

from pyspark.sql.functions import col, lit, concat
postsDF.select(concat('Title: ', postsDF.Title)).show(1)
postsDF.select(concat(lit('Title: '), postsDF.Title)).show(1)


# *****************************************************************************************************
# *****************************************************************************************************
# *** More Columns, Expressions, Cloning, Renaming, Casting & Dropping ***
postsSchema = StructType([
    StructField("Id", IntegerType()),
	StructField("PostTypeId", IntegerType()),
	StructField("AcceptedAnswerId", IntegerType()),
	StructField("CreationDate", TimestampType()),
	StructField("Score", IntegerType()),
	StructField("ViewCount", StringType()),
	StructField("OwnerUserId", IntegerType()),
	StructField("LastEditorUserId", IntegerType()),
	StructField("LastEditDate", TimestampType()),
	StructField("Title", StringType()),
	StructField("LastActivityDate", TimestampType()), 
	ructField("Tags", StringType()),
	StructField("AnswerCount", IntegerType()),
	tField("CommentCount", IntegerType()),
	ld("FavoriteCount", IntegerType())])
	

#Casting columns
postsDF.dtypes
[(x,y) for x, y in postsDF.dtypes if x == 'ViewCount']
postsDF.schema['ViewCount']
postsDF.select('ViewCount').printSchema()
posts_viewDF = postsDF.withColumn('ViewCount', postsDF.ViewCount.cast('integer'))
postsDF_viewDF.select('ViewCount').printSchema()
postsDF.select('ViewCount').printSchema()
posts_viewDF.select('ViewCount').show(5)	
	
# We can rename a column
postsVCDF = postsDF.withColumnRenamed('ViewCount', 'ViewCountStr')
postsVCDF.printSchema()

posts_twoDF = postsDF.withColumnRenamed('ViewCount', 'ViewCountStr').withColumnRenamed('Score', 'ScoreInt')
posts_twoDF.printSchema()

# Some columns might cause problems, you need to escape them wit back ticks
posts_ticksDF = postsDF.withColumnRenamed('ViewCount', 'ViewCount.Str')
posts_ticksDF.select('ViewCount.Str').show(3)

posts_ticksDF.select('`ViewCount.Str`').show()

# Copy columns, several ways to do it, sometimes string, sometimes col objects
posts_wcDF = postsDF.withColumn('TitleClone1', postsDF.Title) 
posts_wcDF.printSchema()
postsDF.withColumn('Title', concat(lit('Title: '),'Title')).select('Title').show(5)

from pyspark.sql.functions import lower
postsDF = postsDF.withColumn('Title', lower(postsDF.Title)).select('Title').show(5)

# Drop a column
posts_wcDF.columns
'TitleClone1' in posts_wcDF.columns
posts_no_cloneDF = posts_wcDF.drop('TitleClone1')
'TitleClone1' in posts_no_cloneDF.columns
posts_no_cloneDF.printSchema()

 
# *****************************************************************************************************
# *****************************************************************************************************
# ***  User Defined Functions (UDFs) on Spark SQL ***
# Change a type on a column
questionsDF = postsDF.filter(col('PostTypeId') == 1)
questionsDF.select('Tags').show(20, truncate=False)

# Define a column based function
def give_me_list(str_lst):
    if str_lst is None or str_lst == '' or str_lst == '[]'  or len(str_lst) < 2:  
        return []
    elements = str_lst[1:len(str_lst) - 1]
    return list(elements.split(','))

list_in_string = '[indentation,line-numbers]'
type(list_in_string)
give_me_list('[list_in_string]')
type(give_me_list('[list_in_string]'))

from pyspark.sql.functions import udf
udf_give_me_list=udf(give_me_list, ArrayType(StringType()))

questions_id_tagsDF = questionsDF.withColumn('Tags',udf_give_me_list(questionsDF['Tags'])).select('Id','Tags')

questions_id_tagsDF.printSchema()
questions_id_tagsDF.select('Tags').show(10, truncate=False)

# Get tags exploded
from pyspark.sql.functions import explode
questions_id_tagsDF.select(explode(questions_id_tagsDF.Tags)).show(10)
questions_id_tagsDF.select(explode(questions_id_tagsDF.Tags)).count()
questions_id_tagsDF.select(explode(questions_id_tagsDF.Tags)).distinct().count()