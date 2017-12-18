txn  =  LOAD  '/home/hduser1/Downloads/txns1.txt'  USING PigStorage(',')  AS  ( txnid, date, custid, amount:double, category, product, city, state, type);

txnbytype = group txn by type;

spendbytype = foreach txnbytype generate group as customer_id, ROUND_TO(SUM(txn.amount ),2) as typesales;

---dump spendbytype;

groupall = group spendbytype all;

--totalsales = foreach groupall generate ROUND_TO(SUM(spendbytype.typesales),2) as totalsales;

--dump totalsales;

final = foreach spendbytype generate $0,$1, ROUND_TO(($1/totalsales.totalsales)*100,2);
---dump final;
 store final into '/home/hduser1/Bigdata/Pig/totalsalespercentage' using PigStorage(',');


----groupall = group final all;
----describe groupall;
----totalcount = foreach groupall generate ROUNT_TO(SUM(final.totalsales),2);
----dump totalcount;
----totalsalesforcust = foreach groupall generate ROUND_TO(SUM(final.totalsales),2);
----dump totalsalesforcust;

