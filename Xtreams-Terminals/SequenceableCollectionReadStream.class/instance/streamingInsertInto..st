"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
streamingInsertInto: aWriteStream
	| count |
	(count := self available) isZero ifTrue: [Incomplete zero raise].
	self streamingInsert: count into: aWriteStream.
	^count
