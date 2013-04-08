"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: queries - server
"
stats: query server: server
"
   The stats command is used to query statistics of certain server.  If
   <query> parameter is omitted, only the end of stats reply is sent
   back.
"
	self send: 'STATS' with: query with: server