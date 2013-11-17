"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
streamingInsert: anInteger into: aWriteStream
	| count |
	count := (writePosition - readPosition) min: anInteger.
	count <= 0 ifTrue: [^0].
	aWriteStream insert: count from: cache at: readPosition + 1.
	self readSkip: count
