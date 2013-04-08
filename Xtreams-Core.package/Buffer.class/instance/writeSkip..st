"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing - writing
"
writeSkip: anInteger
	| old delta |
	old := writePosition.
	self writePosition: old + anInteger.
	delta := writePosition - old.
	^delta