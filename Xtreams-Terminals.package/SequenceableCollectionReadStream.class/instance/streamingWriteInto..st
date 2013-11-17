"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWriteInto: aWriteStream
	| count |
	(count := self available) isZero ifTrue: [^self].
	self streamingWrite: count into: aWriteStream.
	^count
