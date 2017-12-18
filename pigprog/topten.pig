---txn  =  LOAD  '/home/hduser1/Downloads/txns1.txt'  USING PigStorage(',')  AS  ( txnid, date, custid, amount:double, category, product, city, state, type);
---dump txn;

txnbycust = group txn by custid;
--dump txnbycust;

--describe txnbycust;
txnbycust: {group: bytearray,txn: {(txnid: bytearray,date: bytearray,custid: bytearray,amount: double,category: bytearray,product: bytearray,city: bytearray,state: bytearray,type: bytearray)}}

--spendbycust = foreach  txnbycust  generate group as customer_id,  ROUND_TO(SUM(txn.amount ),2) as totalsales;
dump spendbycust;

---custorder = order spendbycust by $1 desc;  ---$1 means second column
dump custorder;
(4007577,5.63) last row

---top10cust = limit custorder 10;
dump top10cust;
(4009485,1973.3)
(4006425,1732.09)
(4000221,1671.47)
(4003228,1640.63)
(4006606,1628.94)
(4006467,1605.95)
(4004927,1576.71)
(4008321,1560.79)
(4000815,1557.82)
(4001051,1488.67)


cust = load  '/home/hduser1/Downloads/custs'  using  PigStorage(',')  AS ( custid, firstname, lastname, age:long, profession);
--describe cust;

top10join = join top10cust by $0, cust by $0;
---dump top10join;

top10 = foreach top10join generate $0, $3, $5, $6, $1;
---dump top10;
(4000221,Glenda,28,Civil engineer,1671.47)
(4000815,Julie,53,Actor,1557.82)
(4001051,Arlene,62,Police officer,1488.67)
(4003228,Elsie,54,Accountant,1640.63)
(4004927,Joan,30,Librarian,1576.71)
(4006425,Joe,30,Economist,1732.09)
(4006467,Evelyn,37,Financial analyst,1605.95)
(4006606,Jackie,66,Recreation and fitness worker,1628.94)
(4008321,Paul,64,Human resources assistant,1560.79)
(4009485,Stuart,58,Teacher,1973.3)


top10order = order top10join by $5 desc;

store top10order into '/home/hduser1/Bigdata/Pig/top10cust' using PigStorage(',');

