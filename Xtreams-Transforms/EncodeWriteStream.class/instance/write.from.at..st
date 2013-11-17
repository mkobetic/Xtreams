"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex

	| character |
	startIndex to: startIndex + anInteger - 1 do:  [:index |
		buffer writeSize < 10 ifTrue: [destination write: buffer readSize from: bufferReading].
		character := aSequenceableCollection at: index.
		character == decodedLineEnd
			ifTrue:	[bufferWriting write: encodedLineEnd]
			ifFalse:	[encoder encode: character on: bufferWriting]].
	destination write: buffer readSize from: bufferReading.
	^anInteger
