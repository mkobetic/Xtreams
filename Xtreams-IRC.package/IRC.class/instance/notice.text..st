"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: commands - channel
"
notice: target text: text
"
   The NOTICE command is used similarly to PRIVMSG.  The difference
   between NOTICE and PRIVMSG is that automatic replies MUST NEVER be
   sent in response to a NOTICE message.  This rule applies to servers too.
"
	self send: 'NOTICE' with: target textchunks: text