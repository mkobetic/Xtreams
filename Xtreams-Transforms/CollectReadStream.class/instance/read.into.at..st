"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex
	direct
		ifTrue:	[self directRead: anInteger into: aSequenceableCollection at: startIndex]
		ifFalse:	[self bufferRead: anInteger into: aSequenceableCollection at: startIndex].
	^anInteger