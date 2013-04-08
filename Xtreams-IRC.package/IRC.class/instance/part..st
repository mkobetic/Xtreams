"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: commands - channel
"
part: channel
"
   The PART command causes the user sending the message to be removed
   from the list of active members for all given channels listed in the
   parameter string.  If a 'Part Message' is given, this will be sent
   instead of the default message, the nickname.  This request is always
   granted by the server.
"
	self send: 'PART' with: channel