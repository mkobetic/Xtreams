"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private-parsing
"
parseFalse

	(self next: 5) = 'false' ifTrue: [^false].
	self error: 'Failed parsing false'