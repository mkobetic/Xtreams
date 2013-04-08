"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: commands - connection
"
quit
"
   A client session is terminated with a quit message.  The server
   acknowledges this by sending an ERROR message to the client.
"
	self send: 'QUIT'