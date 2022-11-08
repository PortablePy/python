"""Show a simple use of RDD API using Spark's committer list

Demo for Pluralsight course:
  Developing Spark Applications Using Python and Cloudera
Created by Xavier Morera
"""

committers = sc.textFile("file:///stackexchange/spark-committers.tsv")

committers.count()

committers_company = committers.map(lambda line: line.split("\t")).filter(lambda x: x[0] != 'Name')

top_companies = committers_company.map(lambda (x,y): (y, 1)).reduceByKey(lambda x, y: x + y)

top_companies_sorted = top_companies.map(lambda (x, y): (y, x)).sortByKey(False).map(lambda (x,y): (y, x))

for tcs in top_companies_sorted.collect():
    print tcs


committer_by_company = sc.textFile("file:///stackexchange/spark-committers.tsv").map(lambda line: line.split("\t")).map(lambda (x,y): (y,1)).reduceByKey(lambda x,y: x + y).map(lambda (x, y): (y, x)).sortByKey(False)

committer_by_company.collect()

for tcs in committer_by_company.collect():
    print tcs
