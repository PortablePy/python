# Note: not meant to be executed as an application, this file has .py extension for display in a code editor
# *** m5 Getting Technical with Spark ***
# This module starts covering the technical bits of Spark

# *****************************************************************************************************
# *****************************************************************************************************
# *** SparkContext and SparkSession
sc
sc.version
type(sc)
help()
dir(sc)

sc.appName
sc.uiWebUrl
sc.applicationId
sc.sparkUser()

sc.textFile('/user/cloudera/spark-committers-no-header.tsv').take(10)
sc.parallelize(['Matei Zaharia','Josh Rosen','Holden Karau'])

spark
type(spark)
spark.sparkContext
spark.sparkContext.textFile('/user/cloudera/spark-committers-no-header.tsv').take(10)

spark.sql('select * from committers').show(10)
spark.sparkContext.textFile('/user/cloudera/spark-committers-no-header.tsv').take(10)

cmDF.select('Name').show(10)

spark.catalog.listDatabases()


# *****************************************************************************************************
# *****************************************************************************************************
# *** Spark Configuration + Deployment Modes

sc.getConf().get('spark.eventLog.dir')
spark_other_session = SparkSession.builder\
.master('yarn')\
.appName('Word Count')\
.config('spark.eventLog.dir', ' /stackexchange/logs')\
.getOrCreate()
spark_other_session.sparkContext.getConf().get('spark.eventLog.dir')
sc.appName
sc.appName
exit()

# Run in terminal
# pyspark2 --name 'Super PySparkShell' --conf 'spark.eventLog.dir=/stackexchange/logs/'
sc.appName
exit()
ls /stackexchange/logs
cat /stackexchange/logs/application_1511794877761_0020


from pyspark import SparkConf, SparkContext
conf=(SparkConf()
    .setMaster("yarn")
    .setAppName("Stack Overflow Test")
    .set("spark.executor.memory","2g"))
sc=SparkContext(conf=conf)

from pyspark import SparkContext 
SparkContext.setSystemProperty('spark.executor.memory','2g')

from pyspark import SparkContext 
sc=SparkContext("yarn","StackOverflowTest", py-Files=['sotest.py','lib.zip'])

# Run in terminal
# spark2-submit --executor-memory 4g stackoverflowtest.py

sc.getConf().getAll()
[(u'spark.driver.host', u'10.0.2.104'), (u'spark.eventLog.enabled', u'true'), (u'spark.ui.proxyBase', u'/proxy/application_1511794877761_0014'), (u'spark.driver.extraLibraryPath', u'/opt/cloudera/parcels/CDH-5.12.1-1.cdh5.12.1.p0.3/lib/hadoop/lib/native'), 

from pyspark.conf import SparkConf 
SparkSession.builder.config(conf=SparkConf())

SparkSession.builder.config('spark.eventLog.dir', '/stackexchange/logs')

spark=SparkSession.builder \
      .master('yarn') \
      .appName('StackOverflowTest') \ 
      .config('spark.executor.memory', '2g') \ 
      .getOrCreate()

spark=SparkSession.builder \
      .master('yarn') \
      .appName('StackOverflowTest') \ 
      .config('spark.submit.deployMode', '') \ 
      .getOrCreate()

spark=SparkSession.builder \
      .master('yarn') \
      .appName('StackOverflowTest') \ 
      .config('spark.submit.deployMode', 'client') \ 
      .getOrCreate()

spark=SparkSession.builder \
      .master('yarn') \
      .appName('StackOverflowTest') \ 
      .config('spark.submit.deployMode', 'cluster') \ 
      .getOrCreate()


# *****************************************************************************************************
# *****************************************************************************************************
# *** Visualizing Your Spark App: Web UI and History Server

sc.getConf().get('spark.driver.appUIAddress')

# alpharetta is the name of the virtual host machine where I have my cluster
# Spark Web UI
# http://alpharetta:4040

# Spark History Server
# http://alpharetta:18089

# *****************************************************************************************************
# *****************************************************************************************************
# *** Logging in Spark and with Cloudera
sc.setLogLevel("ALL")

# Use the inExecutorEntryLogLevelAll.py and inExecutorEntryNoLogLevel.py for playing around with log files

# *****************************************************************************************************
# *****************************************************************************************************
# *** Navigating the Spark Documentation
# https://spark.apache.org/
# https://spark.apache.org/docs/latest/api/python/index.html
# https://www.cloudera.com/products/open-source/apache-hadoop/apache-spark.html