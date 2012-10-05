accessing
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