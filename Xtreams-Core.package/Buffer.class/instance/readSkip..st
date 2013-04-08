"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing - reading
"
readSkip: anInteger
	| old delta |
	old := readPosition.
	self readPosition: old + anInteger.
	delta := readPosition - old.
	^delta