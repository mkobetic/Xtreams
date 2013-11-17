"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
streamingWriteInto: aWriteStream
	| count |
	count := writePosition - readPosition.
	count <= 0 ifTrue: [^0].
	self streamingWrite: count into: aWriteStream.
	^count
