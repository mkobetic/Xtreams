"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: accessing
"
insert: anInteger from: aSequenceableCollection at: startIndex
	| count amount |
	anInteger isZero ifTrue: [^0].

	count := 0.
	[count < anInteger] whileTrue:
		[amount := anInteger - count.
		buffer hasFixedWriteSpace ifTrue: [amount := amount min: buffer cacheSize].
		buffer insert: amount from: aSequenceableCollection at: startIndex + count.

		"There is now data in the buffer for the drain to read"
		readReady signal.
		writeReady wait.
		incompleteCount == nil ifFalse: [(Incomplete count: count + incompleteCount) raise].
		count := count + amount ].
	^anInteger
