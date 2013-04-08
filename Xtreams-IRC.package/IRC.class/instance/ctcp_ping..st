"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: commands - ctcp
"
ctcp_ping: target
	self send: 'PRIVMSG' ctcp: 'PING' from: nil withArguments: (Array with: target) text: nil