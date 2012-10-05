accessing
contentsPast
	| buffer tail |
	cache isEmpty ifTrue: [^self contentsSpecies new].
	tail := (cache size - dataPosition) min: self writePosition.

	buffer := self contentsSpecies withSize: self writePosition.
	buffer replaceFrom: 1 to: tail with: cache startingAt: dataPosition + 1.
	buffer replaceFrom: tail + 1 to: buffer size with: cache startingAt: 1.
	^buffer