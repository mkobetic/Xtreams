accessing
write: anInteger from: aSequenceableCollection at: startIndex
	| count amount |
	anInteger isZero ifTrue: [^0].

	count := 0.
	[count < anInteger] whileTrue:
		[amount := anInteger - count.
		buffer hasFixedWriteSpace ifTrue: [amount := amount min: buffer cacheSize].
		buffer write: amount from: aSequenceableCollection at: startIndex + count.
		
		"There is now data in the buffer for the drain to read"
		readReady signal.
		writeReady wait.
		incompleteCount == nil ifFalse: [(Incomplete count: count + incompleteCount) raise].
		count := count + amount ].
	^anInteger