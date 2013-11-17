"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
privateWrite: anInteger from: aSequenceableCollection at: startIndex
	" Ensure we're only doing with (writePosition + anInteger) <= cache size "
	(writePosition + anInteger) <= cache size ifFalse: [self error: 'invalid privateWrite. Use the #write: protocol instead.'].

	cache replaceFrom: writePosition + 1 to: writePosition + anInteger with: aSequenceableCollection startingAt: startIndex.
	writePosition := writePosition + anInteger.
	writePosition > dataLength ifTrue: [dataLength := writePosition]
