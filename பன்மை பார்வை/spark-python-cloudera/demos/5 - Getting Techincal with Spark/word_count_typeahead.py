"""Shows a simple application for counting words in titles

Demo for Pluralsight course:
  Developing Spark Applications Using Python and Cloudera
Created by Xavier Morera
"""

lines = sc.textFile('file:///stackexchange/simple_titles.txt')
lines.persist()
words = lines.flatMap(lambda line: line.split(' '))
word_for_count = words.map(lambda x: (x,1))
counts = word_for_count.reduceByKey(lambda x,y: x + y)
counts.collect()


