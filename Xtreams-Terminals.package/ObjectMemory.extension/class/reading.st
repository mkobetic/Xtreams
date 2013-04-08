"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: converting
"
reading
	"Return a terminal stream over object memory. Reading from object memory is endless, do not attempt to 'read to the end' without specifying an end condition using #ending: or #limiting:, etc."

	| next |
	next := self someObject.
	^[	| current |
		current := next.
		next := self nextObjectAfter: next.
		current == 0 ifTrue: [ Incomplete zero raise].
		current
	] reading