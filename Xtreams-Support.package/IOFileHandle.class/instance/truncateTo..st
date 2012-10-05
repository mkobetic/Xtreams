read, write, position
truncateTo: pos
	"This is a Xtreams friendly message"

	self position: pos.
	^self primTruncate: handle to: pos