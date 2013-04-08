"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex
	| available |
	available := length - position.
	available < anInteger ifTrue: [self resizeTo: length + anInteger - available].
	self copyFrom: aSequenceableCollection size: anInteger startingAt: startIndex.
	position := position + anInteger.
	^anInteger