accessing
read: anInteger into: aSequenceableCollection at: startIndex
	| count |
	count := anInteger min: self available.
	super read: count into: aSequenceableCollection at: startIndex.
	count < anInteger ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger