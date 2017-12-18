users = LOAD '/home/hduser1/Downloads/weblog' as (user:chararray,gateway:chararray,time:chararray);
---dump users;
 (john,citibank,19.00)
(john,hsbc bank,19.05)
(john,sc bank,17.00)
(john,abc bank,17.05)
(rita,sc bank,11.05)
(rita,abc bank,11.00)

gateways = LOAD '/home/hduser1/Downloads/gateway' as (gateway:chararray,success_rate:float);
--dump gateways;
(citibank,95.0)
(hsbc bank,95.0)
(sc bank,92.0)
(abc bank,85.0)

users_gateways = JOIN users by gateway,gateways by gateway;
---dump users_gateways;
(rita,sc bank,11.05,sc bank,92.0)
(john,sc bank,17.00,sc bank,92.0)
(rita,abc bank,11.00,abc bank,85.0)
(john,abc bank,17.05,abc bank,85.0)
(john,citibank,19.00,citibank,95.0)
(john,hsbc bank,19.05,hsbc bank,95.0)

user_gateways = group users_gateways by user;
---dump user_gateways;
(john,{(john,hsbc bank,19.05,hsbc bank,95.0),(john,citibank,19.00,citibank,95.0),(john,abc bank,17.05,abc bank,85.0),(john,sc bank,17.00,sc bank,92.0)})
(rita,{(rita,abc bank,11.00,abc bank,85.0),(rita,sc bank,11.05,sc bank,92.0)})

user_avg = FOREACH user_gateways generate group,AVG(users_gateways.success_rate) as avgpr;
---dump user_avg;
(john,91.75)
(rita,88.5)

result = FILTER user_avg by avgpr >90.0;
---dump result;
(john,91.75)


store result into '/home/hduser1/Bigdata/Pig/gatewaysout' using PigStorage(',');





