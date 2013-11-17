"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
streamingInsertInto: aWriteStream
	| count |
	count := writePosition - readPosition.
	count <= 0 ifTrue: [^0].
	self streamingInsert: count into: aWriteStream.
	^count
