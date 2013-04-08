"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWrite: anInteger from: aReadStream

	writePosition + anInteger <= cache size ifFalse: [self growBy: anInteger].
	aReadStream read: anInteger into: cache at: writePosition + 1.
	writePosition := writePosition + anInteger.
	writePosition > dataLength ifTrue: [dataLength := writePosition].
	^anInteger