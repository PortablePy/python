"""Show a simple use of Dataset[Row] API using Spark's committer list

Demo for Pluralsight course:
  Developing Spark Applications Using Python and Cloudera
Created by Xavier Morera
"""

committersDF = spark.read.format("csv").option("header", True).option("delimiter", "\t").load("file:///stackexchange/spark-committers.tsv")

committersDF.registerTempTable("committersTable")

spark.sql("Select Organization, count(Organization) From committersTable group by Organization order by count(Organization) desc").show()



