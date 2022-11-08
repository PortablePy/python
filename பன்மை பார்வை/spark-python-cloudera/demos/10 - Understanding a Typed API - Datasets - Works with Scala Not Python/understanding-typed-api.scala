// Note: Not meant to be ran as an application, this file has .scala extension for display in a code editor
// *** m10 Understanding a Typed API - Datasets - Works with Scala Not Python ***
// This is just a simple example of creating a case class and then a Dataset in Spark

// ****************************************************************************************************
// *****************************************************************************************************
// ***  A Quick Look at Datasets ***
// Start with spark2-shell
val commentsDF = spark.read.parquet('/user/cloudera/stackexchange/comments_parquet')
commentsDF.show(3)
case class Comments(Id: Int, PostId: Int, Score: Int, CreationDate: java.sql.Timestamp, UserId: Int)
val commentsDS = commentsDF.as[Comments]
commentsDS
commentsDS.show(3)
