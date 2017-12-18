--pig -x local -p inp=/home/hduser1/file.txt -f wordcount_param.pig

--- pig -p inp=/niit/file.txt -f wordcount_param.pig

---pig -x local -param_file PigInput -f wordcount_param.pig

book = load '$hdfc_inp' using TextLoader () as (lines:chararray);

--dump book;

store book into '$hdfc_op';

--transform = foreach book generate FLATTEN(TOKENIZE(lines)) as word;

--dump transform;

--listofallwords = foreach transform generate word, 1;

dump listofallwords;

--groupbyword = group listofallwords by word;

---dump groupbyword;

--counttofeachword = foreach groupbyword generate group, SUM(listofallwords.$1);

---dump countofeachword;



