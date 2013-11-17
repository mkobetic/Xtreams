"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
gobble
	| object match patternStop progress |
	patternStop := patternStart.
	[hasReread
		ifTrue: [hasReread := false. object := reread. reread := nil]
		ifFalse: [object := source get].
	[(match := object = (pattern at: patternStop)) ifTrue: [patternStop := patternStop + 1].
	match and: [patternStop <= pattern size]]
		whileTrue: [object := source get]]
			on: Incomplete do: [:incomplete |
				sourceAtEnd := substreamAtEnd := true].

	"A full pattern match"
	patternStop > pattern size ifTrue: [
		inclusive ifTrue: [buffer write: pattern size from: pattern at: 1].
		substreamAtEnd := true.
		^self].

	"No match at all, write out the object we just read"
	progress := patternStop - patternStart.
	(patternStart = 1 and: [progress = 0]) ifTrue: [
		sourceAtEnd ifFalse: [buffer put: object].
		patternStart := 1.
		^self].

	"Partial match, write out the part of the pattern previously matched and keep the object we just read to be re-read next time"
	hasReread := true.
	reread := object.
	buffer write: progress from: pattern at: patternStart.
	patternStart := backtrack at: patternStop
