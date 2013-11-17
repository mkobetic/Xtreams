"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
streamingWriteInto: aWriteStream

	| count |
	count := dataLength - readPosition.
	self streamingWrite: count into: aWriteStream.
	^count
