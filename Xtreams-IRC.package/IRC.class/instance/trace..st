"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: queries - server
"
trace: target
"
   TRACE command is used to find the route to specific server and
   information about its peers.  Each server that processes this command
   MUST report to the sender about it.  The replies from pass-through
   links form a chain, which shows route to destination.  After sending
   this reply back, the query MUST be sent to the next server until
   given <target> server is reached.
"
	self send: 'TRACE' with: target