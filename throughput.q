\l trade.q
/update size:"h"$size,price:"e"$price from `trade;
-1"";
show trade
-1"";
t1:trade 0
t10:10#trade
t100:100#trade
t1000:1000#trade
t10000:10000#trade
t15000:15000#trade
t20000:20000#trade
t25000:25000#trade
value"\\t do[25000000;trade,:t1]"; / prepare space

trade:0#trade
ms:value"\\t do[1000000;trade,:t1]"
-1(string 0.001*floor 0.5+(count trade)%ms)," million inserts per second (single insert)";

trade:0#trade
ms:value"\\t do[100000;trade,:t10]"
-1(string 0.001*floor 0.5+(count trade)%ms)," million inserts per second (bulk insert 10)";

trade:0#trade
ms:value"\\t do[10000;trade,:t100]"
-1(string 0.001*floor 0.5+(count trade)%ms)," million inserts per second (bulk insert 100)";

trade:0#trade
ms:value"\\t do[1000;trade,:t1000]"
-1(string 0.001*floor 0.5+(count trade)%ms)," million inserts per second (bulk insert 1000)";

trade:0#trade
ms:value"\\t do[1000;trade,:t10000]"
-1(string 0.001*floor 0.5+(count trade)%ms)," million inserts per second (bulk insert 10000)";

trade:0#trade
ms:value"\\t do[1000;trade,:t15000]"
-1(string 0.001*floor 0.5+(count trade)%ms)," million inserts per second (bulk insert 15000)";

trade:0#trade
ms:value"\\t do[1000;trade,:t20000]"
-1(string 0.001*floor 0.5+(count trade)%ms)," million inserts per second (bulk insert 20000)";

trade:0#trade
ms:value"\\t do[1000;trade,:t25000]"
-1(string 0.001*floor 0.5+(count trade)%ms)," million inserts per second (bulk insert 25000)";

\\
