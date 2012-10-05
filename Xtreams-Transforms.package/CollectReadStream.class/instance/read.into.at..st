accessing
read: anInteger into: aSequenceableCollection at: startIndex
	direct
		ifTrue:	[self directRead: anInteger into: aSequenceableCollection at: startIndex]
		ifFalse:	[self bufferRead: anInteger into: aSequenceableCollection at: startIndex].
	^anInteger