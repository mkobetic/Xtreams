"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: commands - channel
"
kick: nickname from: channel reason: reason
"
   The KICK command can be used to request the forced removal of a user
   from a channel.  It causes the <user> to PART from the <channel> by
   force.  For the message to be syntactically correct, there MUST be
   either one channel parameter and multiple user parameter, or as many
   channel parameters as there are user parameters.  If a 'comment' is
   given, this will be sent instead of the default message, the nickname
   of the user issuing the KICK.
"
	self send: 'KICK' with: nickname with: channel text: reason