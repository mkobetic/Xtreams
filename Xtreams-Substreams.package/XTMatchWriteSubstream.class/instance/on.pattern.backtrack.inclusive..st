initialize-release
on: aDestination pattern: aPattern backtrack: aBacktrack inclusive: aBoolean
	self on: aDestination.
	pattern := aPattern.
	backtrack := aBacktrack.
	patternStart := 1.
	inclusive := aBoolean.
	substreamAtEnd := false