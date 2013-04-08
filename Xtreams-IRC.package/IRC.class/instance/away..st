"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: commands - optional
"
away: text
"
  With the AWAY command, clients can set an automatic reply string for
   any PRIVMSG commands directed at them (not to a channel they are on).
   The server sends an automatic reply to the client sending the PRIVMSG
   command.  The only replying server is the one to which the sending
   client is connected to.
"
	self send: 'AWAY' text: text