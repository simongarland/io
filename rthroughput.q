/ remote throughput, start up an empty q session on port 5555 first
\l trade.q
/update size:"h"$size,price:"e"$price from `trade;
H:hopen 5555
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

H(set;`trade;0#trade);
H(set;`upd;{trade,:x});
H"trade:25000000#trade;"; / prepare space

H"trade:0#trade";
ms:system"t do[1000000;H(`upd;t1)]"
-1(string 0.001*floor 0.5+(H"count trade")%ms)," million inserts per second (single insert)";

H"trade:0#trade";
ms:system"t do[100000;H(`upd;t10)]"
-1(string 0.001*floor 0.5+(H"count trade")%ms)," million inserts per second (bulk insert 10)";

H"trade:0#trade";
ms:system"t do[10000;H(`upd;t100)]"
-1(string 0.001*floor 0.5+(H"count trade")%ms)," million inserts per second (bulk insert 100)";

H"trade:0#trade";
ms:system"t do[1000;H(`upd;t1000)]"
-1(string 0.001*floor 0.5+(H"count trade")%ms)," million inserts per second (bulk insert 1000)";

H"trade:0#trade";
ms:system"t do[1000;H(`upd;t10000)]"
-1(string 0.001*floor 0.5+(H"count trade")%ms)," million inserts per second (bulk insert 10000)";

H"trade:0#trade";
ms:system"t do[1000;H(`upd;t15000)]"
-1(string 0.001*floor 0.5+(H"count trade")%ms)," million inserts per second (bulk insert 15000)";

H"trade:0#trade";
ms:system"t do[1000;H(`upd;t20000)]"
-1(string 0.001*floor 0.5+(H"count trade")%ms)," million inserts per second (bulk insert 20000)";

H"trade:0#trade";
ms:system"t do[1000;H(`upd;t25000)]"
-1(string 0.001*floor 0.5+(H"count trade")%ms)," million inserts per second (bulk insert 25000)";

\\
