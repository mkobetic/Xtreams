"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: instance creation
"
writingDo: aBlock
	| stream |
	stream := self new writing.
	aBlock value: stream.
	^stream
		close;
		destination