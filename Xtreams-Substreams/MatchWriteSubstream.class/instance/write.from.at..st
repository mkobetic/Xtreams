"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex
	| count |
	count := 0.
	[[count < anInteger and: [substreamAtEnd not]] whileTrue:
		[self gobble: (aSequenceableCollection at: startIndex + count).
		count := count + 1]]
			on: Incomplete do: [:incomplete |
				destinationAtEnd := substreamAtEnd := true.
				(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	count < anInteger ifTrue:
		[substreamAtEnd := true.
		(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
