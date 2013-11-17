"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
streamingInsert: anInteger into: aWriteStream

	| read amount tail head |
	amount := (dataLength - readPosition) min: anInteger.
	read := (dataPosition + readPosition) \\ cache size.
	tail := cache size - read min: amount.
	head := amount - tail.
	aWriteStream insert: tail from: cache at: read + 1.
	head <= 0 ifTrue: [^self readSkip: tail].
	aWriteStream insert: head from: cache at: 1.
	self readSkip: tail + head
