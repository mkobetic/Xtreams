private
streamingInsertInto: aWriteStream
	| count |
	(count := self available) isZero ifTrue: [Incomplete zero raise].
	self streamingInsert: count into: aWriteStream.
	^count