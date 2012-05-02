private
calcFractionPart
	| n i tmp |
	tmp := (ByteArray new: 10) writing.
	i := 0.
	n := number fractionPart.
	[n > 0 and: [i < decimalPlaces]] whileTrue: 
		[n := n * base.
		tmp put: n floor.
		n := n fractionPart.
		i := i + 1].
	(number respondsTo: #scale) ifTrue:
		[number scale - tmp length timesRepeat: [tmp put: 0]].
	fraction := tmp conclusion.