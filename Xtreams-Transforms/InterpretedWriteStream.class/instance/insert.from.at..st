"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: accessing
"
insert: anInteger from: aSequenceableCollection at: startIndex

	| count amount |
	count := 0.
	[count = anInteger] whileFalse: 
		[amount := cacheSize min: anInteger - count.
		0 to: amount - 1 do:  [:index | operation value: cache value: index * elementSize + 1 value: (aSequenceableCollection at: index + startIndex)].
		destination insert: amount * elementSize from: cache at: 1.
		count := count + amount].
	^anInteger
