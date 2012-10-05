accessing
insert: anInteger from: aSequenceableCollection at: startIndex
	"Implementation note: this code does a memory move to the right.
	Since Squeak primitive #replaceFrom:to:with: is implemented with a memcpy rather than a memmove, it cannot work.
	We have to buffer the copy in a motionBuffer temporary."
	| motionBuffer |
	motionBuffer := destination.
	destination := destination grownBy: (anInteger max: destination size).
	destination replaceFrom: position + anInteger + 1 to: length + anInteger with: motionBuffer startingAt: position + 1.
	destination replaceFrom: position + 1 to: position + anInteger with: aSequenceableCollection startingAt: startIndex.
	position := position + anInteger.
	length := length + anInteger.
	^anInteger