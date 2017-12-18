claims = LOAD '/home/hduser1/Downloads/medical' as (name,dept,amount);
dump claims;
(amy,hr,8000)
(jack,hr,7500)
(joe,finance,9000)
(daniel,admin,4750)
(tim,TS,4750)
(tim,TS,3500)
(tim,TS,2750)

employee_claims = group claims by name;
---dump employee_calaims;
(amy,{(amy,hr,8000)})
(joe,{(joe,finance,9000)})
(tim,{(tim,TS,2750),(tim,TS,3500),(tim,TS,4750)})
(jack,{(jack,hr,7500)})
(daniel,{(daniel,admin,4750)})


employee_avg = FOREACH employee_claims generate group as user , AVG(claims.amount) as numclaims;
---dump employee_avg;
(amy,8000.0)
(joe,9000.0)
(tim,3666.6666666666665)
(jack,7500.0)
(daniel,4750.0)


store employee_avg into '/home/hduser1/Bigdata/Pig/medical1' using PigStorage(',');
