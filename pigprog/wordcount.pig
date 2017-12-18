word_data = LOAD '/home/hduser1/Bigdata/Pig/wordcount' using TextLoader() as (word:chararray);
--dump word_data;

(hadoop hadoop )
(mahout)
(mahout pig)
(hadoop pig)
(hbase hbase)
(hbase hadoop)


words = FOREACH word_data generate FLATTEN(TOKENIZE(word));
--dump words;

(hadoop)
(hadoop)
(mahout)
(mahout)
(pig)
(hadoop)
(pig)
(hbase)
(hbase)
(hbase)
(hadoop)

grouped = group words by $0;
--dump grouped;

(pig,{(pig),(pig)})
(hbase,{(hbase),(hbase),(hbase)})
(hadoop,{(hadoop),(hadoop),(hadoop),(hadoop)})
(mahout,{(mahout),(mahout)})


word_counts = FOREACH grouped generate group, COUNT(words);
--dump word_counts;
(pig,2)
(hbase,3)
(hadoop,4)
(mahout,2)


store word_counts into '/home/hduser1/Bigdata/Pig/wordcount1' using PigStorage(',');

