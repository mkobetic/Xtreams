"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing - reading
"
read: anInteger into: aSequenceableCollection at: startIndex
	| count read tail |

	count := anInteger min: (dataLength - readPosition).
	read := (dataPosition + readPosition) \\ cache size.
	tail := (cache size - read) min: count.

	aSequenceableCollection replaceFrom: startIndex to: startIndex + tail - 1 with: cache startingAt: read + 1.
	aSequenceableCollection replaceFrom: startIndex + tail to: startIndex + count - 1 with: cache startingAt: 1.
	readPosition := readPosition + count.

	count < anInteger ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger