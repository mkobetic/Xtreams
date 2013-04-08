"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: queries - service
"
servlist
"
   The SERVLIST command is used to list services currently connected to
   the network and visible to the user issuing the command.  The
   optional parameters may be used to restrict the result of the query
   (to matching services names, and services type).
"
	self send: 'SERVLIST'