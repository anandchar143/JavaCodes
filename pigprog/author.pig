book_info = LOAD '/home/hduser1/Downloads/book-data' USING PigStorage(',') AS (book_id:int, price:int, author_id:int);

author_info = LOAD '/home/hduser1/Downloads/author-data' USING PigStorage(',') AS (author_id:int, author_name:chararray);

--dump book_info;

--dump author_info;

book_info_filtered = FILTER book_info by price >=200;
---dump book_info_filtered;

author_info_filtered = FILTER author_info by INDEXOF(author_name,'J',0)==0;

----dump author_info_filtered;

book_author_info = JOIN book_info_filtered BY author_id,author_info_filtered BY author_id;

---dump book_author_info;


store book_author_info '/home/hduser1/Bigdata/Pig/authorout' using PigStorage(',');


