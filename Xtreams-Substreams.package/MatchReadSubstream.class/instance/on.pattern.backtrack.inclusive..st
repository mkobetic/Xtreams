"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aSource pattern: aPattern backtrack: aBacktrack inclusive: aBoolean
	self on: aSource.
	pattern := aPattern.
	inputBuffer := RingBuffer new: 1 class: self contentsSpecies.
	outputBuffer := RingBuffer new: pattern size class: self contentsSpecies.
	candidate := 1.
	backtrack := aBacktrack.
	inclusive := aBoolean.
	substreamAtEnd := false