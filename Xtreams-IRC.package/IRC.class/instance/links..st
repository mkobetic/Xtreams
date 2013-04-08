"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: queries - server
"
links: mask
"
   With LINKS, a user can list all servernames, which are known by the
   server answering the query.  The returned list of servers MUST match
   the mask, or if no mask is given, the full list is returned.
"
	self send: 'LINKS' with: mask