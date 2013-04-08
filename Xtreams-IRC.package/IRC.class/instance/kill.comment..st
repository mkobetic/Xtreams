"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: commands - misc
"
kill: nickname comment: comment
"
   The KILL command is used to cause a client-server connection to be
   closed by the server which has the actual connection.  Servers
   generate KILL messages on nickname collisions.  It MAY also be
   available available to users who have the operator status.
"
	self send: 'KILL' with: nickname text: comment