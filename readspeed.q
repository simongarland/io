/ q readspeed.q [-run] [-prepare] [-flush memsizeingb]
/ eg: q readspeed.q -prepare
/     q readspeed.q -flush 32 -run

STDOUT:-1
if[0=count .z.x;STDOUT">q ",(string .z.f)," -prepare -run -flush memsizeGB";exit 1]
argvk:key argv:.Q.opt .z.x
PREPARE:`prepare in argvk
FLUSH:`flush in argvk
RUN:`run in argvk

if[PREPARE;
	t:([]hh:100000000?100000h);
	update sshh:asc hh from `t;
	update ii:`int$2*hh from `t;
	update bb:hh=4567h from `t;
	update cc:100000000?.Q.A from `t;
	rsave `t;
	STDOUT"tmp db <t> created"]

if[FLUSH;
	STDOUT"memory flushed (",$[count mem:first argv`flush;mem;"1"],"GB)";
	key each(floor 1^"E"$first argv`flush)#key 250000000]

if[RUN;
	value"\\l t";
	STDOUT"* boolean";
	STDOUT"from disk";
	STDOUT"million records/second(b): ",string floor 0.5+(count t)%1000*value"\\t select i from t where bb=1b";
	STDOUT"from memory";
	STDOUT"million records/second(b): ",string floor 0.5+(count t)%1000*value"\\t select i from t where bb=1b";
	STDOUT"* single char";
	STDOUT"from disk";
	STDOUT"million records/second(c): ",string floor 0.5+(count t)%1000*value"\\t select i from t where cc=\"x\"";
	STDOUT"from memory";
	STDOUT"million records/second(c): ",string floor 0.5+(count t)%1000*value"\\t select i from t where cc=\"x\"";
	STDOUT"* sorted short";
	STDOUT"from disk";
	STDOUT"million records/second(`s#h): ",string floor 0.5+(count t)%1000*value"\\t select i from t where sshh=4567h";
	STDOUT"from memory";
	STDOUT"million records/second(`s#h): ",string floor 0.5+(count t)%1000*value"\\t select i from t where sshh=4567h";
	STDOUT"* short";
	STDOUT"from disk";
	STDOUT"million records/second(h): ",string floor 0.5+(count t)%1000*value"\\t select i from t where hh=4567h";
	STDOUT"from memory";
	STDOUT"million records/second(h): ",string floor 0.5+(count t)%1000*value"\\t select i from t where hh=4567h";
	STDOUT"* int";
	STDOUT"from disk";
  STDOUT"million records/second(i): ",string floor 0.5+(count t)%1000*value"\\t select i from t where ii=4567i";
	STDOUT"from memory";
	STDOUT"million records/second(i): ",string floor 0.5+(count t)%1000*value"\\t select i from t where ii=4567i"]

\\
