"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: commands - ctcp
"
ctcp_finger: target
	self send: 'PRIVMSG' ctcp: 'FINGER' from: nil withArguments: (Array with: target) text: nil