# Note: not meant to be executed as an application, has .py extension for display in a code editor
# *** m7 Going Deeper into Spark Core***
# This module goes deeper into the RDD API

#************************************************************************************************
#************************************************************************************************
# *** A Closer Look at Map, FlatMap, Filter and Sort ***

# Get our data, namely our words
lines = sc.textFile('/user/cloudera/stackexchange/simple_titles_txt')
lines.collect()
for l in lines.collect():
    print l

words_in_line = lines.map(lambda x: x.split(' '))
for wil in words_in_line.collect():
    print wil


# Flatmap is to 0, 1 or more
words = lines.flatMap(lambda line: line.split(' '))
words.collect()

# And we apply a function over all words with map
words.collect()
word_for_count = words.map(lambda x: (x,1))
word_for_count.take(1)
word_for_count.take(5)

# Filter is another transformation where we pass the function that if returns false, the element is not moved to the next RDD
def starts_h(word):
    return word[0].lower().startswith('h')

word_for_count.filter(starts_h).collect()

# Let's do an aggregation - we will explain this in more detail later
word_for_count.take(1)
word_count = word_for_count.reduceByKey(lambda x,y: x + y)
word_count.take(10)
word_count = sortByKey().collect()
word_count = sortByKey(False).collect()
word_count.map(lambda (x,y):(y,x)).sortByKey().map(lambda (x,y):(y,x)).collect()
word_count.sortBy(lambda (x,y): -y).collect()

 
#************************************************************************************************
#************************************************************************************************
# *** How Can I Tell It Is a Transformation *** 
lines = sc.textFile('/user/cloudera/stackexchange/simple_titles_txt')
words = lines.flatMap(lambda line: line.split(' ‘))
word_for_count = words.map(lambda x: (x,1))
grouped_words = word_for_count.reduceByKey(lambda x,y: x + y)
grouped_words.collect()


#************************************************************************************************
#************************************************************************************************
# *** Why Do We Need Actions? ***
lines = sc.textFile('/user/cloudera/stackexchange/simple_titles_txt')
words = lines.flatMap(lambda line: line.split(' ‘))
word_for_count = words.map(lambda x: (x,1))
grouped_words = word_for_count.reduceByKey(lambda x,y: x + y)
grouped_words.collect()


#************************************************************************************************
#************************************************************************************************
# *** Partition Operations: MapPartitions and PartitionBy ***
badges_columns_rdd.take(1)
badges_for_part = badges_columns_rdd.map(lambda x: (x[2],x)).repartition(50)
print badges_for_part.partitioner

#numPartitions = badges_columns_rdd.map(lambda x: x[2]).distinct().count()
def badge_partitioner(badge):
    return hash(badge)

badges_by_badge = badges_for_part.partitionBy(50, badge_partitioner)
print badges_by_badge.partitioner

badges_for_part.saveAsTextFile('/user/cloudera/stackexchange/badges_no_partitioner')
badges_by_badge.saveAsTextFile('/user/cloudera/stackexchange/badges_yes_partitioner')

# Use glom 
badges_by_badge.map(lambda (x,y): x).glom().take(1)
badges_by_badge.map(lambda (x,y): x).glom().take(2)
badges_by_badge.map(lambda (x,y): x).glom().take(1)

# Add up all entries per partition
def count_badges(iterator):
    total = 0
    for ite in iterator:
      total += 1
    yield total

counted_badges = badges_by_badge.mapPartitions(count_badges)
counted_badges.collect()
	
def next_value(value_list):
    for i in value_list:
    yield i
test_yield = next_value([1, 2, 3])
test_yield.next()
test_yield.next()
test_yield.next()
test_yield.next()

#************************************************************************************************
#************************************************************************************************
# *** Sampling Your Data and Distinct***
posts_all.count()
sample_posts = posts_all.sample(False,0.1,50)
sample_posts.count()

posts_all.count()
posts_all.countApprox(100, 0.95)

# Take a sample
posts_all.takeSample(False,15,50)
len(posts_all.takeSample(False,10,50))

#************************************************************************************************
#************************************************************************************************
# *** Set Operations: join, union, ... ***
# Prerequisites: have CSV of Posts.xml, created with prepare_data_posts_csv.py

# Create two RDDs, questions asked and questions responded
questions = sc.parallelize([("xavier",1),("troy",2),("xavier",5)])
answers = sc.parallelize([("xavier",3),("beth",4)])
questions.collect() 
answers.collect()

# We can use union to concatenate both RDDs
questions.union(answers).collect()
questions.union(questions).collect()
questions.union(sc.parallelize(['irene', 'juli', 'luci'])).collect()

# And use join to determine who has asked and responded
questions.join(answers).collect()
questions.join(sc.parallelize(range(10))).collect()

# Or all, but with a None for those that have only either asked or responded
questions.fullOuterJoin(answers).collect()

# We can also do a left outer join to get a list of those who have only asked. If they haven't responded there will be a null
questions.leftOuterJoin(answers).collect()

# right outer join 
questions.rightOuterJoin(answers).collect()

# Needless to say, a leftOuterJoin on one RDD is the same as a rightOuterJoin on the other one 
questions.leftOuterJoin(answers).collect()
answers.rightOuterJoin(questions).collect()

#Cartesian
questions.cartesian(answers).collect()

#************************************************************************************************
#************************************************************************************************
# *** Combining, Aggregating, Reducing and Grouping on PairRDDs ***
posts_all.take()
each_post_owner = posts_all.map(lambda x: x.split(",")[6])
posts_owner_pair_rdd = each_post_owner.map(lambda x: (x,1))
posts_owner_pair_rdd.take(1)

# Group by Key
top_posters_gbk = posts_owner_pair_rdd.groupByKey()
top_posters_gbk.take(10)
top_posters_gbk.map(lambda (x,y): (x,list(y))).take(10)
top_posters_gbk.map(lambda (x,y): (x,len(y))).take(10)
top_posters_gbk.map(lambda (x,y): (x,len(y))).sortByKey(lambda (x,y): -y).take(1)


# Reduce by key
# Need to import operator
from operator import add
top_posters_rbk = posts_owner_pair_rdd.reduceByKey(add)
top_posters_rbk.lookup('51')

# Both counts match
top_posters_gbk.count()
top_posters_rbk.count()

# Aggregate by key is similar to reduceByKey
# We can calculate average score per question by user

posts_all_entries = posts_all.map(lambda x: x.split(","))
questions = posts_all_entries.filter(lambda x: x[1] == "1")
user_question_score = questions.map(lambda x: (x[6],int(x[4])))
user_question_score.take(5)

for_keeping_count = (0,0)
aggregated_user_question = user_question_score.aggregateByKey(for_keeping_count, lambda tuple_sum_count, next_score: (tuple_sum_count[0] + next_score, tuple_sum_count[1] + 1), lambda tuple_sum_count, tuple_next_partition_sum_count:  (tuple_sum_count[0] + tuple_next_partition_sum_count[0], tuple_sum_count[1] + tuple_next_partition_sum_count[1]))
aggregated_user_question.take(1)
average_user_question.lookup("51")

# Combine by key

def to_list(postid):
     return [postid]

def merge_posts(posta, postb):
    posta.append(postb)
    return posta

def combine_posts(posta, postb):
    posta.extend(postb)
    return posta

combined = user_post.combineByKey(to_list, merge_posts, combine_posts)
combined.filter(lambda (x,y): x == '51').collect()


#************************************************************************************************
#************************************************************************************************
# *** ReduceByKey vs. GroupByKey: Which One is Better? ***
# Both can be used for the same purpose, but they work very different internally
add_them = lambda x,y: x + y
add_in_list = lambda x: sum(list(x))
reduced = word_for_count.reduceByKey(add_them)
grouped = word_for_count.groupByKey().mapValues(add_in_list)
reduced.take(1)
grouped.take(1)
reduced.count()
grouped.count()


#************************************************************************************************
#************************************************************************************************
# *** Grouping Data into Buckets with Histogram ***
badges_reduced.take(10)
badges_reduced.map(lambda (x,y): y).histogram(7)
badges_reduced.map(lambda (x,y): y).histogram([0,1000,2000,3000,4000,5000,6000,7000])
badges_reduced.sortBy(lambda x: -x[1]).take(10)
badges_reduced.filter(lambda x: x[1] < 1000).count()


#************************************************************************************************
#************************************************************************************************
# *** Caching and Data Persistence ***
reduced.setName('Reduced RDD')
reduced.cache()

reduced.cache()
grouped.persist()


#************************************************************************************************
#************************************************************************************************
# *** Shared Variables: Accumulators and Broadcast ***
counted_badges.collect()
sum(counted_badges.collect())
print counted_badges.toDebugString()

# Create accumulator
accumulator_badge = sc.accumulator(0)
accumulator_badge

# Create a function that will increase the value
def add_badge(item):
    accumulator_badge.add(1)

# Execute with every item, this is an action
badges_by_badge.foreach(add_badge)

# Get final value
accumulator_badge.value
 
# Broadcast variable
users_all.take(10)
users_columns = users_all.map(split_the_line)
users_columns.take(3)

top_posters_rbk.take(10)
top_posters_rbk.lookup('51')

tp = top_posters_rbk.collectAsMap()
broadcast_tp = sc.broadcast(tp)

def get_name(user_column):
    user_id = user_column[0]
    user_name = user_column[3]    
    user_post_count = '0'
    if user_id in broadcast_tp.value:
        user_post_count = broadcast_tp.value[user_id]    
    return (user_id, user_name, user_post_count)

user_info = users_columns.map(get_name)
user_info.take(10)


#************************************************************************************************
#************************************************************************************************
# *** Developing Self Contained PySpark Application, Packages and Files ***
from pyspark import SparkContext
sc = SparkContext("yarn", "Standalone App")

spark2-submit --py-files dependency.egg --jars ... 

spark2-submit <params-dependencies-conf> prepare_posts.py