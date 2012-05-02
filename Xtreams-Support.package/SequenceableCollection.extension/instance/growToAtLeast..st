*Xtreams-Support
growToAtLeast: requestedSize
	"NOTE: since becomeForward: is known to be inefficient, use parsimoniously."
	
	| bigger sz |
	(sz := self size) >= requestedSize
		ifTrue: [^self ].
	bigger := self grownBy: (sz max: requestedSize - sz).
	^self becomeForward: bigger