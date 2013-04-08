"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private-parsing
"
parseTrue

	(self next: 4) = 'true' ifTrue: [^true].
	self error: 'Failed parsing true'