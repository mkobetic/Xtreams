"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex
	| count wrote |
	anInteger isZero ifTrue: [^0].
	count := 0.
	[count < anInteger] whileTrue:
		[wrote := destination nextPutBytes: anInteger - count from: aSequenceableCollection startingAt: startIndex + count.
		wrote isZero ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
		count := count + wrote].
	^anInteger
