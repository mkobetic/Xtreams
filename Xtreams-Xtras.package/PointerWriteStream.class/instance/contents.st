"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
contents
	| cache |
	cache := self contentsSpecies withSize: position.
	destination copyAt: 0 to: cache size: position startingAt: 1.
	^cache