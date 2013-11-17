"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex
	| count |
	count := anInteger min: self available.
	aSequenceableCollection replaceFrom: startIndex to: startIndex + count - 1 with: source startingAt: position + 1.
	position := position + count.
	count < anInteger ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
