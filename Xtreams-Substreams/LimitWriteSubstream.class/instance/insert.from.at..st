"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
insert: anInteger from: aSequenceableCollection at: startIndex
	| count |
	count := anInteger min: self available.
	super insert: count from: aSequenceableCollection at: startIndex.
	count < anInteger ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
