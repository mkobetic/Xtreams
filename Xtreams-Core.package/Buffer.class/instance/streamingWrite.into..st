"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWrite: anInteger into: aWriteStream
	| count |
	count := (writePosition - readPosition) min: anInteger.
	count <= 0 ifTrue: [^0].
	aWriteStream write: count from: cache at: readPosition + 1.
	self readSkip: count.
	^count
