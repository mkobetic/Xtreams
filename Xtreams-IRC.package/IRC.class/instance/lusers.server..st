"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: queries - server
"
lusers: mask server: server
"
   The LUSERS command is used to get statistics about the size of the
   IRC network.  If no parameter is given, the reply will be about the
   whole net.
"
	self send: 'LUSERS' with: mask with: server