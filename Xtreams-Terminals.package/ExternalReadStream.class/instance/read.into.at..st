"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex

	| index toRead |
	anInteger isZero ifTrue: [^0].
	index := startIndex.
	toRead := anInteger.
	[toRead > 0] whileTrue: [ | amount |
		cachePosition < cacheDataSize ifFalse: [
			cachePosition := 0.
			cacheDataSize := (toRead max: self bytesForRead) min: cache size.
			cacheDataSize := self readBytes: cacheDataSize into: cache startingAt: 1.
			cacheDataSize isZero ifTrue: [ self incompleteRead: (Incomplete on: aSequenceableCollection count: anInteger - toRead at: startIndex) ] ].
		amount := (cacheDataSize - cachePosition) min: toRead.
		aSequenceableCollection replaceFrom: index to: index + amount - 1 with: cache startingAt: cachePosition + 1.
		cachePosition := cachePosition + amount.
		index := index + amount.
		toRead := toRead - amount ].
	^anInteger
