book = load '$inp' using TextLoader() as (lines:chararray);

-----dump book;

--transform = foreach book generate FLATTEN(TOKENIZE(lines)) as word;

-dump transform;

--listofallwords = foreach transform generate word, 1;

-dump listofallwords;

--groupbyword = group listofallwords by word;

-dump groupbyword;

--countofeachword = foreach groupbyword generate group, SUM(listofallwords.$1);

-dump counttofeachword;


