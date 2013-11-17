"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
streamingWriteInto: aWriteStream
	| count |
	(count := self available) isZero ifTrue: [^self].
	self streamingWrite: count into: aWriteStream.
	^count
