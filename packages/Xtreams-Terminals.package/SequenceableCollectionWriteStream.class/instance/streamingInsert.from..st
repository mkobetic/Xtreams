private
streamingInsert: anInteger from: aStreamable
	"Implementation note: this code does a memory move to the right.
	Since Squeak primitive #replaceFrom:to:with: is implemented with a memcpy rather than a memmove, it cannot work.
	We have to buffer the copy in motionBuffer temporary."
	| reading motionBuffer |
	reading := aStreamable reading.
	motionBuffer := destination.
	destination := destination grownBy: (destination size max: anInteger).
	destination replaceFrom: position + anInteger to: anInteger + motionBuffer size with: motionBuffer startingAt: position.
	[reading read: anInteger into: destination at: position + 1]
		on: Incomplete do: [:error | position := position + error count. error pass].
	position := position + anInteger