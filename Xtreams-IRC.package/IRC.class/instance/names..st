"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: commands - channel
"
names: channel
"
   By using the NAMES command, a user can list all nicknames that are
   visible to him. For more details on what is visible and what is not,
   see 'Internet Relay Chat: Channel Management' [IRC-CHAN].  The
   <channel> parameter specifies which channel(s) to return information
   about.  There is no error reply for bad channel names.
"
	self send: 'NAMES' with: channel