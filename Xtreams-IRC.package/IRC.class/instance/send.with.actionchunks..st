"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - sending
"
send: aCommand with: arg1 actionchunks: aText
	self send: aCommand ctcp: 'ACTION' from: nil withArguments: (Array with: arg1) textchunks: aText