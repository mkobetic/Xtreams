"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex
	| count |
	count := 0.
	[[count < anInteger] whileTrue:
		[aSequenceableCollection at: startIndex + count put: source value.
		count := count + 1]]
			on: Incomplete do: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
