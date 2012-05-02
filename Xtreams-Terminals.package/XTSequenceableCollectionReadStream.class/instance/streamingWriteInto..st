private
streamingWriteInto: aWriteStream
	| count |
	(count := self available) isZero ifTrue: [^self].
	self streamingWrite: count into: aWriteStream.
	^count