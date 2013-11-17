"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aDestination pattern: aPattern backtrack: aBacktrack inclusive: aBoolean
	self on: aDestination.
	pattern := aPattern.
	backtrack := aBacktrack.
	patternStart := 1.
	inclusive := aBoolean.
	substreamAtEnd := false
