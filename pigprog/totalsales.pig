To calculate total sales
bagname = Group <oldbag> ALL

Track customers whose age less then 50 and total purchase done more then usd 500

1)load the table and customer table

-----txn  =  LOAD  '/home/hduser1/Downloads/txns1.txt'  USING PigStorage(',')  AS  ( txnid, date, custid, amount:double, category, product, city, state, type);

-----cust = load  '/home/hduser1/Downloads/custs'  using  PigStorage(',')  AS ( custid, firstname, lastname, age:long, profession);

2) group by txn table by custid

----txnbycust =  group txn by custid;
-----dump txnbycust;

3)sum totals for each cust id

-----spendbycust = foreach txnbycust generate group as customer_id, ROUND_TO(SUM(txn.amount ),2) as totalsales;

4) Filter on the above to get cust id totalsales>500

------cust500 = filter spendbycust by $1 >500;
	---dump cust500;

5)join this data with customer data

-----joined = join cust500 by $0, cust by $0; 
---dump joined;

6)filter on age column
---final_join = foreach joined generate $0, $3, $4, $5, $6, $1;
----final = filter final_join by $3 < 50;
----dump final;

----groupall = group final all;
----describe groupall;

----totalcount = foreach groupall generate COUNT(final);
----dump totalcount;

---store final into '/home/hduser1/Bigdata/Pig/ageandpurchase' using PigStorage(',');



