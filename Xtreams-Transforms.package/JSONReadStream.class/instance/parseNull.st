"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private-parsing
"
parseNull

	(self next: 4) = 'null' ifTrue: [^nil].
	self error: 'Failed parsing null'