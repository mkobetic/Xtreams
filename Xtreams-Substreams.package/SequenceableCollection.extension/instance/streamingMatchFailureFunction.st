"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingMatchFailureFunction
	"Compute the array that tells us how far we need to back up when a match fails. This is using the Knuth-Morris-Pratt matching algorithm"

	| backtrack position candidate |
	backtrack := #(0 1), (Array new: self size - 2). 
	candidate := 1.
	position := 3.

	[position <= self size] whileTrue: [
		(self at: position - 1) = (self at: candidate)
			ifTrue: [
				candidate := candidate + 1.
				backtrack at: position put: candidate.
				position := position + 1]
			ifFalse: [
				candidate > 1
					ifTrue: [candidate := backtrack at: candidate]
					ifFalse: [backtrack at: position put: 1. position := position + 1]]].

	^backtrack