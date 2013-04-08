"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: commands - optional
"
server_rehash
"
   The rehash command is an administrative command which can be used by
   an operator to force the server to re-read and process its
   configuration file.
"
	self send: 'REHASH'