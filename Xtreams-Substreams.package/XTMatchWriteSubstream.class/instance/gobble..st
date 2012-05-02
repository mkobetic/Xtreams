private
gobble: anObject
	| patternStop match |
	patternStop := patternStart.
	(match := anObject = (pattern at: patternStop)) ifTrue: [patternStop := patternStop + 1].

	"A full pattern match"
	patternStop > pattern size ifTrue: [
		inclusive ifTrue: [destination write: pattern size from: pattern at: 1].
		substreamAtEnd := true.
		^self].

	"Partial match, in progress"
	match ifTrue: [patternStart := patternStop. ^self].

	"No match at all, write out the object we just read"
	patternStart = 1 ifTrue: [
		destination put: anObject.
		patternStart := 1.
		^self].

	"Partial match was in progress, but anObject didn't match, so write out the part of the pattern and try anObject again from the backtrack position"
	destination write: patternStart - 1 from: pattern at: 1.
	patternStart := backtrack at: patternStop.
	self gobble: anObject