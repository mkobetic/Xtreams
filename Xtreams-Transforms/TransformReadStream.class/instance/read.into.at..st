"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
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
