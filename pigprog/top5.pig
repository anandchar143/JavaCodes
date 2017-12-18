data2000  =  LOAD  '/home/hduser/2000.txt'  USING PigStorage(',')  AS  (catid:chararray,catname:chararray,jan:double,feb:double,mar:double,apr:double,may:double,june:double,july:double,aug:double,sept:double,oct:double,nov:double,dec:double);
data2001  =  LOAD  '/home/hduser/2001.txt'  USING PigStorage(',')  AS  (catid:chararray,catname:chararray,jan:double,feb:double,mar:double,apr:double,may:double,june:double,july:double,aug:double,sept:double,oct:double,nov:double,dec:double);
data2002  =  LOAD  '/home/hduser/2002.txt'  USING PigStorage(',')  AS  (catid:chararray,catname:chararray,jan:double,feb:double,mar:double,apr:double,may:double,june:double,july:double,aug:double,sept:double,oct:double,nov:double,dec:double);

joindata = join data2000 by catid,data2001 by catid,data2002 by catid;
--dump joindata;
descjoin = limit (order joindata by $2 desc) 5;
ascjoin = limit (order joindata by $2 asc) 5;
--dump descjoin;
store descjoin into '/home/hduser/Bigdata/pig/Datasetassign/top5' using PigStorage(',');
