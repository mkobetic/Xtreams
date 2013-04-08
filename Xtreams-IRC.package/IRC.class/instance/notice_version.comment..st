"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: commands - ctcp
"
notice_version: target comment: comment
	self send: 'NOTICE' ctcp: 'VERSION' from: nil withArguments: (Array with: target) text: comment