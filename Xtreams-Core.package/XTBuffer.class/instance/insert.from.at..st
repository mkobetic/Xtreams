accessing - writing
insert: anInteger from: aSequenceableCollection at: startIndex
	"Implementation note: this code does a memory move to the right.
	Since Squeak primitive #replaceFrom:to:with: is implemented with a memcpy rather than a memmove, it cannot work.
	We have to buffer the copy in a motionBuffer temporary."

	| motionBuffer |
	motionBuffer := cache copyFrom: writePosition + 1 to: dataLength.
	dataLength + anInteger <= cache size ifFalse: [self growBy: anInteger].

	cache replaceFrom: writePosition + anInteger + 1 to: dataLength + anInteger with: motionBuffer startingAt: 1.
	cache replaceFrom: writePosition + 1 to: writePosition + anInteger with: aSequenceableCollection startingAt: startIndex.
	writePosition := writePosition + anInteger.
	dataLength := dataLength + anInteger.
	^anInteger