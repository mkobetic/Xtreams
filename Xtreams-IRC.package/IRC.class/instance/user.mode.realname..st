"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: commands - connection
"
user: user mode: mode realname: realname
"
   The USER command is used at the beginning of connection to specify
   the username, hostname and realname of a new user.
"
	self send: 'USER' with: user with: mode with: '*' text: realname