"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex
	| count |
	count := anInteger min: self available.
	aSequenceableCollection replaceFrom: startIndex to: startIndex + count - 1 with: source startingAt: position + 1.
	position := position + count.
	count < anInteger ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
