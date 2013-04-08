"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWriteInto: aWriteStream

	| count |
	count := dataLength - readPosition.
	self streamingWrite: count into: aWriteStream.
	^count