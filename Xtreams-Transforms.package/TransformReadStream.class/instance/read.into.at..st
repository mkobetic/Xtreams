"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex
	| count read |
	anInteger isZero ifTrue: [^0].
	count := 0.
	[count < anInteger] whileTrue:
		[(self fillBufferIfRequired: anInteger - count) ifFalse: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
		read := (anInteger - count) min: buffer readSize.
		buffer read: read into: aSequenceableCollection at: startIndex + count.
		count := count + read].
	^anInteger
