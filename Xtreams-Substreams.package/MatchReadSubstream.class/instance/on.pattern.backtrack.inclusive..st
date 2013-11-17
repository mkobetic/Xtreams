"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aSource pattern: aPattern backtrack: aBacktrack inclusive: aBoolean
	self on: aSource.
	pattern := aPattern.
	buffer := RingBuffer new: pattern size class: self contentsSpecies.
	hasReread := false.
	backtrack := aBacktrack.
	patternStart := 1.
	inclusive := aBoolean.
	substreamAtEnd := false
