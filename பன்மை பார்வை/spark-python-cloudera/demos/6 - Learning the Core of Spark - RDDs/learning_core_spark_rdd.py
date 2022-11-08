# Note: not meant to be executed as an application, this file has .py extension for display in a code editor
# *** m6  Learning the Core of Spark: RDDs ***
# In this module we will learn about the RDD API

# ***************************************************************************************
# ***************************************************************************************
# *** SparkContext: The Entry Point to a Spark Application***
# The SparkContext is used 
pyspark2
sc
spark.sparkContext
dir(sc)
sc.serializer
sc.sparkUser
sc.sparkUser()
help(sc)
q
sc.stop()
sc
test_rdd = sc.emptyRDD()
sc = SparkContext.getOrCreate()
test_rdd = sc.emptyRDD()
test_rdd

# ***************************************************************************************
# *** Creating RDDs with Parallelize ***
# Parallelize is used to create RDDs, usually for testing or to operate with larger RDDs

# Here is a simple RDD with just five elements, I can see how many partitions are created. Also I can use dir() to see the valid attributes of an object
[1,2,3,4,5]
type([1,2,3,4,5])
list_one_to_five=sc.parallelize([1,2,3,4,5])
list_one_to_five
list_one_to_five.collect()

# And you can specify how many partitions you want
list_one_to_five.getNumPartitions()
list_one_to_five.glom().collect()
list_one_to_five = sc.parallelize([1,2,3,4,5], 1)
list_one_to_five.getNumPartitions()
list_one_to_five.glom().collect()

#
dir(list_one_to_five)
help(list_one_to_five)
q

# Perform operations
list_one_to_five.sum()
list_one_to_five.min()
list_one_to_five.max()
list_one_to_five.mean()
list_one_to_five.first()

# RDDs can hold objects of different types, key/value pairs being common (tuple)
list_dif_types = sc.parallelize([False, 1, "two", {'three': 3}, ('xavier', 4)])
list_dif_types.collect()
tuple_rdd = sc.parallelize([('xavier', 1),('irene', 2)])
tuple_rdd
tuple_rdd.setName('tuple_rdd')
tuple_rdd

# RDDs can be empty too, and you can check if they are
empty_rdd = sc.parallelize([])
empty_rdd.collect()
empty_rdd.isEmpty()
other_empty = sc.emptyRDD()
other_empty.isEmpty()

# We can create a longer list and play around with partitions. 
bigger_rdd = sc.parallelize(range(1,1000))
bigger_rdd.collect()
bigger_rdd.sum()
bigger_rdd.count()
bigger_rdd.getNumPartitions()


# ***************************************************************************************
# ***************************************************************************************
# *** Returning Data to the Driver, i.e. collect(), take(), first()... ***
# Many methods to bring back data
bigger_rdd.collect()
bigger_rdd.take(10)
bigger_rdd.first()
help(bigger_rdd.takeOrdered)
q
bigger_rdd.takeOrdered(10, key=lambda x: -x)

tuple_map = tuple_rdd.collectAsMap()
type(tuple_map) 
tuple_map['xavier']

# And iterate over the data
for elem in bigger_rdd.take(10):
    print elem

for key, value in tuple_map.iteritems():
    print key + ' / ' + str(value)

# Foreach runs method on each element in RDD
import urllib2

def log_search(q):
    url_log = 'http://www.bigdatainc.org/' + q
    response = urllib2.urlopen(url_log)
    print url_log

queries = sc.parallelize(['ts1', 'ts2'])
queries.foreach(log_search)


# ***************************************************************************************
# ***************************************************************************************
# *** Partitions, Repartition, Coalesce, Saving as Text and HUE ***
bigger_rdd.getNumPartitions()
play_part = bigger_rdd.repartition(10)
play_part.getNumPartitions()

# But try to increase number of partitions with both repartition and coalesce
# Coalesce can only be used to decrease partitions, and it has the advantage that it minimizes data movement as explained in the video. Repartition works as indicated.
play_part.repartition(14).getNumPartitions()
play_part.coalesce(15).getNumPartitions()

# But how do we really know the data is being partitioned? Save the RDD and visualize in HUE
play_part.saveAsTextFile('/user/cloudera/tests/play_part/ten')
# Now try with repartition(), increasing the number of partitions and visualize in HUE
play_part.repartition(4).saveAsTextFile('/user/cloudera/tests/play_part/four')
# Now try with coalesce(), we will get 1 file
play_part.coalesce(1).saveAsTextFile('/user/cloudera/tests/play_part/coalesce')
play_part.coalesce(1).saveAsTextFile('/user/cloudera/tests/play_part/coalesce')


#************************************************************************************************
#************************************************************************************************
# *** Creating RDDs from External Datasets ***
sc.textFile('/user/cloudera/tests/play_part/ten').count()
sc.textFile('/user/cloudera/tests/play_part/four').count()
sc.textFile('/user/cloudera/tests/play_part/coalesce').count()
sc.textFile('/user/cloudera/tests/play_part/four/part-00000').count()

# You can also load locally - note: Spark's behavior is different between Yarn and Standalone in term of defaults
# Upload the file to only one machine when working in a cluster, you will get a file not found exception (in standalone it will not make a difference)
# Upload to all machines and you will see it working
local_play = sc.textFile('file:///stackexchange/play_part/')
local_play.count()
local_play.take(10)

# Let's load our StackOverflow posts
posts_all = sc.textFile('/user/cloudera/stackexchange/posts_all_csv')
posts_all.count()

# Load users_csv file
users_all = sc.textFile('/user/cloudera/stackexchange/users_csv')
users_all.take(1)

# Load CSV when using textFile has caveats
def split_the_line(x):
    return x.split(',')

badges_rdd_csv.map(split_the_line).take(1)

numbers_partitions = sc.wholeTextFiles('/user/cloudera/tests/play_part/four')

numbers_partitions.take(1)
numbers_partitions.take(1)[0][0]
numbers_partitions.take(1)[0][1]

# You can load JSON files as well
tags_json = sc.textFile('/user/cloudera/stackexchange/tags_json')
tags_json.first()

# And you can also upload to S3, you need to set your access key id and secret (there are more secure ways of doing this)

# There are a couple of steps, you need to load the Hadoop and AWS libraries, it can be done with the steps below
#   pyspark2 --packages org.apache.hadoop:hadoop-aws:2.7.3,com.amazonaws:aws-java-sdk:1.7.4
# You then need to set the access key and secret access key, there are several ways. You can set the access and secret key, it has to be done in all nodes
#   export AWS_ACCESS_KEY_ID="access-key"
#   export AWS_SECRET_ACCESS_KEY="secret-key"
# Another possibility is to use jceks 
#   hadoop credential create fs.s3a.access.key -provider jceks://hdfs/user/root/awskeyfile.jceks -value <accesskey>
#   hadoop credential create fs.s3a.secret.key -provider jceks://hdfs/user/root/awskeyfile.jceks -value <secretkey>
#   pyspark2 --conf spark.hadoop.hadoop.security.credential.provider.path=jceks://hdfs/user/root/awskeyfile.jceks 
#   sc.textFile('s3a://pluralsight-spark-cloudera-python/spark-committers-no-header.tsv').take(3)
# You could also set using configuration
#   sc._jsc.hadoopConfiguration().set("fs.s3.awsAccessKeyId", '<accesskey>')
#   sc._jsc.hadoopConfiguration().set("fs.s3.awsSecretAccessKey", '<secretkey>')
# Or in core-site.xml using the Safety Valve from Cloudera Manager
# There are many ways, some more secure than others. Please check Cloudera's documentation for more information on setting access keys
 # Additional note: please make sure ntp service is running and there is no clock offset issue. This may cause an issue.

pyspark2 --packages org.apache.hadoop:hadoop-aws:2.7.3,com.amazonaws:aws-java-sdk:1.7.4

tags_json_s3 = sc.textFile('s3a://pluralsight-spark-cloudera-python/part-00000')
tags_json_s3.take(10) 

 
#************************************************************************************************
#************************************************************************************************
# *** Saving Data as PickleFile, SequenceFile, NewAPIHadoopFile, ... ***

# textFile is the most common way of reading 
badges_columns_rdd.take(1)
badges_columns_rdd.take(1)[0][2]
badges_columns_rdd.saveAsTextFile('/user/cloudera/stackexchange/badges_txt')

# Reload and see what happens
badges_reloaded = sc.textFile('/user/cloudera/stackexchange/badges_txt')
badges_reloaded.take(1)
badges_reloaded.take(1)[0]
badges_reloaded.take(1)[0][0]

badges_columns_rdd.take(1)
badges_columns_rdd.take(1)[0][2]

# Now let's use PickleFile
badges_columns_rdd.saveAsPickleFile('/user/cloudera/stackexchange/badges_pickle')
badges_reload_pickle = sc.pickleFile('/user/cloudera/stackexchange/badges_pickle')
badges_columns_rdd.(1)[0][2]
badges_reload_pickle.take(1)[0][2]

# Use tags, whole files
tags_partitions.saveAsSequenceFile('/user/cloudera/stackexchange/tags_sequence')
tags_sequence = sc.sequenceFile('/user/cloudera/stackexchange/tags_sequence')
tags_sequence.first()

# This will fail as sequence files need to be key/value
badges_columns_rdd.saveAsSequenceFile('/user/cloudera/stackexchange/badges_sequence')

#************************************************************************************************
#************************************************************************************************
# *** Creating RDDs with Transformations ***
rdd_reuse = sc.parallelize([1,2])
rdd_reuse.collect
rdd_reuse = sc.parallelize([3,4])
rdd_reuse.collect

# Now let's say that we want to create several RDDs with the end goal of counting the badges
badges_entry = badges_columns_rdd.map(lambda x: x[2])
badges_name = badges_entry.map(lambda x: (x,1))
badges_reduced = badges_name.reduceByKey(lambda x, y: x + y)
badges_count_badge = badges_reduced.map(lambda (x,y): (y,x))
badges_sorted = badges_count_badge.sortByKey(False).map(lambda (x, y): (y, x))
badges_sorted.take(10)
badges_sorted.take(1)

# You can list RDDs
locals()
globals()
vars()
from pyspark import RDD
for(k,v)in locals().items():
    if isinstance(v,RDD):
        print k

		
#************************************************************************************************
#************************************************************************************************
# *** A Little Bit More on Lineage ***
# To see RDD Lineage
badges_sorted
badges_sorted.toDebugString()
# At this point go check the details for this job in the Spark UI, you will see how they match and the shuffle boundaries are pretty obvious
print badges_sorted.toDebugString()

# And you can inspect a bit more with prev
badges_sorted.prev
badges_sorted.prev.take(1)

