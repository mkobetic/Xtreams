"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingInsertInto: aWriteStream
	| count |
	(count := self available) isZero ifTrue: [Incomplete zero raise].
	self streamingInsert: count into: aWriteStream.
	^count
