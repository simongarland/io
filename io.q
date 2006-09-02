/ q io.q [-run] [-prepare] [-cleanup] [-flush memsizeingb] [-rl remotelocation] [-rh remotehost] / hardware timings 
/ eg: q io.q -prepare -rl /mnt/foo
/     q io.q -flush 32 -run -rl /mnt/foo -rh server19:5005
/     q io.q -cleanup -rl /mnt/foo 
/ if remote host/location aren't supplied only local tests will be run 
/ start local and remote q servers manually 

STDOUT:-1
if[0=count .z.x;STDOUT">q ",(string .z.f)," -prepare -run -flush memsizeGB -cleanup -rh host:port -rl remotelocation";exit 1]
argvk:key argv:.Q.opt .z.x
PREPARE:`prepare in argvk
CLEANUP:`cleanup in argvk
FLUSH:`flush in argvk
RUN:`run in argvk
RH:`rh in argvk 
RL:`rl in argvk

lh:`$":127.0.0.1:",string localport:5555
LH:not 0=@[hopen;lh;0]

ffile:`:file.test / local fileops test
lrfile:`:read.test / local read file
lwfile:`:write.test / local write file
rrfile:` sv(hsym`$first argv`rl),`read.test
rwfile:` sv(hsym`$first argv`rl),`write.test
msstring:{(string x)," ms"}

SAMPLESIZE:5000000
ssm:floor 4*SAMPLESIZE%1e6
read:{[file]
	STDOUT"hclose hopen`",(string file)," ",msstring 0.0001*value"\\t do[10000;hclose hopen`",(string file),"]";
	STDOUT"read `",(string file)," - ",(string floor 0.5+1000*ssm%value"\\t read1`",string file)," MB/sec";
	STDOUT"read `",(string file)," - ",(string floor 0.5+1000*ssm%value"\\t read1`",string file)," MB/sec (cached)";}
write:{[file]STDOUT"write `",(string file)," - ",(string floor 0.5+1000*ssm%value "\\t `",(string file)," 1:SAMPLESIZE#key 11+rand 111")," MB/sec";hdel file;}

fileops:{sx:string x;
	STDOUT".[`",sx,";();,;2 3] ",msstring 0.001*value"\\t do[1000;.[`",sx,";();,;2 3]]";
	STDOUT".[`",sx,";();:;2 3] ",msstring 0.001*value"\\t do[1000;.[`",sx,";();:;2 3]]";
	H::hopen x;
	STDOUT"append (2 3) to handle ",msstring 0.00001*value"\\t do[100000;H(2 3)]";
	STDOUT"hcount`",sx," ",msstring 0.00001*value"\\t do[100000;hcount`",sx,"]";
	STDOUT"read1`",sx," ",msstring 0.0001*value"\\t do[10000;read1`",sx,"]";
	STDOUT"value`",sx," ",msstring 0.0001*value"\\t do[10000;value`",sx,"]";
	}

comm:{sx:string x;
	STDOUT"hclose hopen`",sx," ",msstring 0.001*value"\\t do[1000;hclose hopen`",sx,"]";
	H::hopen x;
	STDOUT"sync (key rand 100) ",msstring 0.00001*value"\\t do[100000;H\"key rand 100\"]";
	STDOUT"async (string 23);collect ",msstring 0.00001*value"\\t do[100000;(neg H)\"23\"];H\"23\"";
	STDOUT"sync (string 23) ",msstring 0.00001*value"\\t do[100000;H\"23\"]"}

if[PREPARE;
	/ prepare files for read, then do something else for a while to get them out of the cache
	if[RL;t:rrfile 1:SAMPLESIZE#key 11+rand 111];
	t:lrfile 1:SAMPLESIZE#key 11+rand 111;
	t:.[ffile;();:;2 3];
	STDOUT"start local q server with: q -p ",string localport;
	/ value"\\start \"hardware test\" q -p ",string localport;
	STDOUT"tmpfiles created"]

if[FLUSH;
	STDOUT"memory flushed (",$[count mem:first argv`flush;mem;"1"],"GB)";
	key each(floor 1^"E"$first argv`flush)#key 250000000]

if[RUN;
	STDOUT(string .z.f)," - ",(string `date$.z.Z)," ",(string `minute$.z.Z)," ",(string .z.h)," - times in ms for single execution";
	STDOUT"* local file";read[lrfile];write[lwfile];
	STDOUT"* local fileops";fileops[ffile];
	if[LH;STDOUT"* local comm";comm[lh]];
	if[RL;STDOUT"* remote file";read[rrfile];write[rwfile]];		
	if[RH;STDOUT"* remote comm";comm[hsym `$first argv`rh]]] 

if[CLEANUP;
	@[hdel;lrfile;()];@[hdel;ffile;()];
	if[RL;@[hdel;rrfile;()]];
	STDOUT"tmpfiles deleted"]
\\
