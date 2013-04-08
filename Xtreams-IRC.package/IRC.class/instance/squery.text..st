"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: queries - service
"
squery: servicename text: text
"
   The SQUERY command is used similarly to PRIVMSG.  The only difference
   is that the recipient MUST be a service.  This is the only way for a
   text message to be delivered to a service.
"
	self send: 'SQUERY' with: servicename text: text