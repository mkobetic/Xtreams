"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: commands - ctcp
"
notice_errmsg: target message: message
	self send: 'NOTICE' ctcp: 'ERRMSG' from: nil withArguments: (Array with: target) text: message