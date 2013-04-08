"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: commands - channel
"
list: channel
"
   The list command is used to list channels and their topics.  If the
   <channel> parameter is used, only the status of that channel is
   displayed.
"
	self send: 'LIST' with: channel