"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: commands - ctcp
"
notice_ping: target
	self send: 'NOTICE' ctcp: 'PING' from: nil withArguments: (Array with: target) text: Timestamp now printString