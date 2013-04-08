"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: commands - optional
"
wallops: text
"
   The WALLOPS command is used to send a message to all currently
   connected users who have set the 'w' user mode for themselves.  (See
   Section 3.1.5 User modes).
"
	self send: 'WALLOPS' textchunks: text