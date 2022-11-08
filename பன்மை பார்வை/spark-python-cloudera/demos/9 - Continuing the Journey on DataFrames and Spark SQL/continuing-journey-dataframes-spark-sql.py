# Note: not meant to be executed as an application, this file has .py extension for display in a code editor
# *** m9 Continuing the Journey with Spark SQL ***
# This module continues on the journey with DataFrames and Spark SQL
# *****************************************************************************************************
# *****************************************************************************************************
# *** Querying DataFrames (And Sorting, Alias, ...) ***
postsDF.show()

# Here is how I select the column, I get a new DataFrame
postsDF.select('Id')
postsDF.select('Id').show()
postsDF.select('Id').show(5)
postsDF.select('Id').limit(5).show()
postsDF.select('Id', 'Title').show(5)

postsDF.select(postsDF['Id'], postsDF.Title, col('Score'), 'CreationDate').show(5)
postsDF.select(postsDF['Id'], postsDF.Title, col('Score') * 1000, 'CreationDate').show(5)

# Filtering Data, use where() and filter()
# Filter and where are aliases
postsDF.filter(col('PostTypeId') == 1).count()
postsDF.where(col('PostTypeId') == 1).count()
postsDF.select(col('PostTypeId')).distinct().show()

#Evaluationg conditions
from pyspark.sql.functions import when
postsDF.select('Id', when(col('PostTypeId')==1, 'Question').otherwise('Other'), 'Title').show(5)
postsDF.select('Id', when(col('PostTypeId')==1, 'Question').otherwise('Other').alias('PostType'), 'Title').show(5)

# Multiple conditions in an expressions
postsDF.where((col('PostTypeId') == 5) | (col('PostTypeId') == 1)).count()
postsDF.where((col('PostTypeId') == 5) & (col('PostTypeId') == 1)).count()

# Ordering results 
qDF = questionsDF.select('Title', 'AnswerCount', 'Score')
qDF.orderBy('AnswerCount').show(5)
qDF.orderBy('AnswerCount', ascending=False).show(5)
qDF.sort('AnswerCount', ascending=False).show(5)

# Also use asc and desc functions
from pyspark.sql.functions import asc, desc

from pyspark.sql.functions import asc, desc
qDF.orderBy(desc('AnswerCount'), asc('Score')).show(5)


# *****************************************************************************************************
# *****************************************************************************************************
# *** What To Do With Missing or Corrupt Data ***

# Removing nulls
postsDF.select('Id', 'Title').show(10)
postsDF.select('Id', 'Title').dropna().show(10)
postsDF.select('Id', 'Title').dropna(how='any').show(10)
postsDF.select('Id', 'Title').dropna(how='all').show(10)
postsDF.select('Id', 'Title').dropna(subset='Title').show(10)

# Replacing & Filling
postsDF.select('Id', 'Title').replace('How can I add line numbers to Vim?', '[Redacted]').show(5)
postsDF.select('Id', 'Title').fillna('[N/A]').show(5)

# Create a bad record
badges_columns_rdd.toDF().write.json('/user/cloudera/stackexchange/badges_records')
badgesDF = spark.read.json('/user/cloudera/stackexchange/badges_records')
badgesDF.show(5)

# Handling corrupt data
badgesDF = spark.read.json('/user/cloudera/stackexchange/badges_records',mode='PERMISSIVE')
badgesDF.show(5)
badgesDF = spark.read.json('/user/cloudera/stackexchange/badges_records',mode='PERMISSIVE', columnNameOfCorruptRecord='Invalid')
badgesDF.show(5)
badgesDF = spark.read.json('/user/cloudera/stackexchange/badges_records',mode='DROPMALFORMED')
badgesDF.show(5)
badgesDF = spark.read.json('/user/cloudera/stackexchange/badges_records',mode='FAILFAST')
badgesDF.show(5)

# *****************************************************************************************************
# *****************************************************************************************************
# *** Saving DataFrames ***

# Nothing specified, saves as parquet, and I can see there is only 1 partition
postsDF.write.save('/user/cloudera/stackexchange/dataframes/just_save')
postsDF.rdd.getNumPartitions()

# I can repartition my dataframe and save, now I will get two partitions
postsDF.rdd.repartition(2).toDF().write.save('/user/cloudera/stackexchange/dataframes/two_partitions')

# I can save as text, and here is where the differences start
# If you want to save as text, it has to be text, not columnar data. This was different with RDDs
postsDF.write.format('text').save('/user/cloudera/stackexchange/dataframes/just_text')

# Now save only 1 column
postsDF.select('Title').write.format('text').save('/user/cloudera/stackexchange/dataframes/just_text')

# Although you can use text, but in a columnar format, namely CSV
postsDF.write.format('csv').save('/user/cloudera/stackexchange/dataframes/format_csv')
postsDF.write.csv('/user/cloudera/stackexchange/dataframes/just_csv')

# Output options
postsDF.write.option('header', True).csv('/user/cloudera/stackexchange/dataframes/csv_h')

# And there are savemodes, with RDDs you cannot overwrite
postsDF.rdd.saveAsTextFile('/user/cloudera/stackexchange/dataframes/just_rdd')
postsDF.rdd.saveAsTextFile('/user/cloudera/stackexchange/dataframes/just_rdd')

# But it is possible with dataframes
postsDF.write.csv('/user/cloudera/stackexchange/dataframes/repeat_df')
postsDF.write.csv('/user/cloudera/stackexchange/dataframes/repeat_df')
postsDF.write.mode('overwrite').csv('/user/cloudera/stackexchange/dataframes/repeat_df')
postsDF.write.mode('overwrite').csv('/user/cloudera/stackexchange/dataframes/repeat_df')
postsDF.write.mode('overwrite').csv('/user/cloudera/stackexchange/dataframes/repeat_df')


# *****************************************************************************************************
# *****************************************************************************************************
# *** Spark SQL: Querying Using Temporary Views ***

# Now just use SQL
spark.sql('select * from PostsDF').show()

# Temporary Views in Spark SQL
postsDF.createOrReplaceTempView('Posts')
spark.sql('select count(*) from Posts')
spark.sql('select count(*) from Posts').show()
spark.sql('select count(*) as TotalPosts from Posts').show()
spark.sql("select Id, Title, ViewCount, AnswerCount from Posts").show(5, truncate=False)

# And also use the Spark SQL functions
from pyspark.sql.functions import reverse
top_viewsDF = spark.sql("select Id, reverse(Title) as eltiT, ViewCount, AnswerCount from Posts order by ViewCount desc")
top_viewsDF.select('eltiT', 'ViewCount').show(5, truncate=False)


# *****************************************************************************************************
# *****************************************************************************************************
# *** Loading Files and Views into DataFrames Using Spark SQL ***
comments_loadedDF = spark.sql('select * from parquet.`/user/cloudera/stackexchange/comments_parquet`')
comments_loadedDF.show(5)

# And you can run queries
spark.sql('select * from parquet.`/user/cloudera/stackexchange/comments_parquet` order by Score desc').show(5)

comments_loadedDF.createOrReplaceTempView('comments')

# And load using table
comments_reloadedDF = spark.table('comments')
comments_reloadedDF.orderBy.show(5) 
comments_reloadedDF.orderBy('score', ascending=False).show(5) 


# *****************************************************************************************************
# *****************************************************************************************************
# *** Saving to Persistent Tables ***

postsDF.write.saveAsTable('posts_savetable_nooption')
spark.sql('select * from posts_savetable_nooption')
spark.sql('select * from posts_savetable_nooption').show()

postsDF.write.option('path', '/user/cloudera/stackexchange/tables').saveAsTable('posts_savetable_option')
spark.sql('select * from posts_savetable_option').show(3)

# Please see known issue
# https://www.cloudera.com/documentation/spark2/latest/topics/spark2_known_issues.html#SPARK-21994

# *****************************************************************************************************
# *****************************************************************************************************
# ***  Hive Support and External Databases ***
# You can connect to a database
ls -l mysql-connector-java-5.1.41-bin.jar
pyspark2 --jars mysql-connector-java-5.1.41-bin.jar
external_databaseDF = spark.read.format("jdbc").option("url", "jdbc:mysql://dn04.cloudera/scm").option("driver", "com.mysql.jdbc.Driver").option("dbtable", "COMMANDS").option("user", "scm_user").option("password", "scm_pwd").load()
external_databaseDF.count()
external_databaseDF.columns
external_databaseDF.show(5)
 
# Or to Hive
# warehouse_location points to the default location for managed databases and tables
# Configure Hive as Service wide from configuration in Cloudera Manager

from os.path import abspath

warehouse_location = abspath('/user/hive/warehouses/')

spark_hive = SparkSession.builder.appName("Hive Demo with Spark") \
    .config("spark.sql.warehouse.dir", warehouse_location) \
    .enableHiveSupport() \
    .getOrCreate()

spark_hive.sql("show databases").show()

spark_hive.sql("Select * from default.spark_python_posts").show(5)

# *****************************************************************************************************
# *****************************************************************************************************
# *** Aggregating, Grouping and Joining ***

commentsDF = spark.read.parquet('/user/cloudera/stackexchange/comments_parquet')
commentsDF.show(5)

# group by and then aggregate
# Get grouped data
commentsDF.groupBy('UserId')
dir(commentsDF.groupBy('UserId'))

commentsDF.groupBy('UserId').sum('Score').show(5)
commentsDF.groupBy('UserId').sum('Score').sort('sum(Score)', ascending=False).show(5)

# which one has the greater average
commentsDF.groupBy('UserId').avg('Score').sort('avg(Score)', ascending=False).show(5)

# Use agg
import pyspark.sql.functions as func
commentsDF.groupBy('UserId').agg(func.avg('Score'), func.count('Score')).alias('Total')).show(5)
commentsDF.groupBy('UserId').agg(func.mean('Score'), func.count('Score')).alias('Total')).sort('avg(Score)', ascending=False).show(5)
commentsDF.groupBy('UserId').agg(func.mean('Score'), func.count('Score')).alias('Total')).sort('Total', ascending=False).show(5)

#Describe
commentsDF.describe().show(5)
commentsDF.describe('Score').show(5)

# Joining Data
postsDF
ask_questionsDF = postsDF.where('PostTypeId == 1').select('OwnerUserId').distinct()
answer_questionsDF = postsDF.where('PostTypeId == 2').select('OwnerUserId').distinct()

postsDF.select('OwnerUserId').distinct().count()
ask_questionsDF.count()
answer_questionsDF.count()

ask_questionsDF.join(answer_questionsDF, ask_questionsDF.OwnerUserId == answer_questionsDF.OwnerUserId).count()

#Spark SQL
commentsDF.createOrReplaceTempView('comments')
spark.sql('Select UserId, count(Score) as TotalCount From comments Group by UserId Order by TotalCount desc').show(5)


# *****************************************************************************************************
# *****************************************************************************************************
# *** The Catalog API ***

spark.catalog
dir(spark.catalog)
spark.catalog.listDatabases()

for d in spark.catalog.listDatabases():
    print d

spark.catalog.listTables('default')
len(spark.catalog.listTables('default'))
spark.catalog.dropTempView('comments')
len(spark.catalog.listTables('default'))