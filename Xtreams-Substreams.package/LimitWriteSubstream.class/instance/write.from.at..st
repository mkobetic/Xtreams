"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex
	| count |
	count := anInteger min: self available.
	super write: count from: aSequenceableCollection at: startIndex.
	count < anInteger ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
