\l trade.q
tmp:-1""
show trade
tmp:-1""
t1:trade 0
t10:10#trade
t100:100#trade
t1000:1000#trade
t10000:10000#trade
t25000:25000#trade
tmp:value"\\t do[1000000;trade,:t1]" / prepare space

trade:0#trade
ms:value"\\t do[1000000;trade,:t1]"
tmp:-1(string 0.001*floor 0.5+(count trade)%ms)," million inserts per second (single insert)"

trade:0#trade
ms:value"\\t do[100000;trade,:t10]"
tmp:-1(string 0.001*floor 0.5+(count trade)%ms)," million inserts per second (bulk insert 10)"

trade:0#trade
ms:value"\\t do[10000;trade,:t100]"
tmp:-1(string 0.001*floor 0.5+(count trade)%ms)," million inserts per second (bulk insert 100)"

trade:0#trade
ms:value"\\t do[1000;trade,:t1000]"
tmp:-1(string 0.001*floor 0.5+(count trade)%ms)," million inserts per second (bulk insert 1000)"

trade:0#trade
ms:value"\\t do[100;trade,:t10000]"
tmp:-1(string 0.001*floor 0.5+(count trade)%ms)," million inserts per second (bulk insert 10000)"

trade:0#trade
ms:value"\\t do[100;trade,:t25000]"
tmp:-1(string 0.001*floor 0.5+(count trade)%ms)," million inserts per second (bulk insert 25000)"

\\
