"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: commands - connection
"
mode: nickname changes: anArray
"
   The user MODE's are typically changes which affect either how the
   client is seen by others or what 'extra' messages the client is sent.
"
	self send: 'MODE' withArguments: (Array with: nickname), anArray