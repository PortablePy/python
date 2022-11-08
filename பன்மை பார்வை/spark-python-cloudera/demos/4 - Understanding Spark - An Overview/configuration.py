"""Shows how to work with configuration in Spark

Demo for Pluralsight course:
  Developing Spark Applications Using Python and Cloudera
Created by Xavier Morera
"""

# Let's create a new SparkSession and change a configuration from code, this is the highest priority
# But check first current log location
sc.getConf().get('spark.eventLog.dir')
# Here is the new session 
spark_other_session = SparkSession.builder \
                    .master('yarn') \
                    .appName('Word Count') \
                    .config('spark.eventLog.dir', '/stackexchange/logs') \
                    .getOrCreate()

# And let's check it actually changed
spark_other_session.sparkContext.getConf().get('spark.eventLog.dir')
# Let's remember this
sc.appName

# Let's exit and start 
#   exit()
# The log location must exist or else we will get an exception when logging starts upon launch
#   mkdir /stackexchange/logs
# Run below from terminal to load configuration
# pyspark2 --name 'Super PySparkShell' --conf 'spark.eventLog.dir=/stackexchange/logs'
# Now let's check the changes
sc.appName
sc.getConf().get('spark.eventLog.dir')
sc.applicationId
# Now exit and go see the logs directory
ls /stackexchange/logs
# Do a cat on the application log