"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
privateWrite: anInteger from: aSequenceableCollection at: startIndex
	" Ensure we're only doing with (writePosition + anInteger) <= cache size "
	(writePosition + anInteger) <= cache size ifFalse: [self error: 'invalid privateWrite. Use the #write: protocol instead.'].

	cache replaceFrom: writePosition + 1 to: writePosition + anInteger with: aSequenceableCollection startingAt: startIndex.
	writePosition := writePosition + anInteger.
	writePosition > dataLength ifTrue: [dataLength := writePosition]
