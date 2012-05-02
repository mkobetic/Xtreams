private
calcWholePart
	| tmp n |
	tmp := ByteArray new writing.
	n := number floor.
	n = 0 ifTrue: [tmp put: 0].
	[ n > 0 ] whileTrue: 
		[tmp put: (n rem: base).
		n := n quo: base].
	whole := tmp conclusion.
	