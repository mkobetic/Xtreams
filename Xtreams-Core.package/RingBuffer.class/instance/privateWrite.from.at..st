"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
privateWrite: anInteger from: aSequenceableCollection at: startIndex
	| write tail |

	anInteger > 0 ifFalse: [^self].
	" Ensure we're only doing with anInteger <= cache size "
	anInteger > cache size ifTrue: [self error: 'invalid privateWrite. Use the #write: protocol instead.'].

	write := (dataPosition + writePosition) \\ cache size.
	tail := (cache size - write) min: anInteger.

	cache replaceFrom: write + 1 to: write + tail with: aSequenceableCollection startingAt: startIndex.
	cache replaceFrom: 1 to: anInteger - tail with: aSequenceableCollection startingAt: startIndex + tail.

	self privateWrapDataPosition: anInteger.
	writePosition := (writePosition + anInteger) min: cache size.
	writePosition > dataLength ifTrue: [dataLength := writePosition]
