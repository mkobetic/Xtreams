"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex

	| toFlush bufferFlush |
	(buffer hasFixedWriteSpace not or: [buffer writeSize >= anInteger ]) ifTrue: [
		buffer write: anInteger from: aSequenceableCollection at: startIndex.
		^anInteger ].
	toFlush := buffer readSize + anInteger - buffer cacheSize.
	bufferFlush := toFlush min: buffer readSize.
	destination write: bufferFlush from: buffer.
	(toFlush > bufferFlush) ifTrue: [
		toFlush := toFlush - bufferFlush.
		destination write: toFlush from: aSequenceableCollection at: startIndex ].
	buffer write: anInteger - toFlush from: aSequenceableCollection at: startIndex + toFlush.
	^anInteger