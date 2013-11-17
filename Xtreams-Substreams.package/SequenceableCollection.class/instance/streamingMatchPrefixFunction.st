"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: xtreams
"
streamingMatchPrefixFunction
	"Compute the array that tells us how far we need to back up when a match fails. This is using the Knuth-Morris-Pratt matching algorithm"

	| backtrack partialMatch |
	backtrack := Array new: self size + 1.
	backtrack at: 1 put: 1; at: 2 put: 1.
	partialMatch := 1.

	2 to: self size do: [:index |
		| current |
		current := self at: index.

		"If there's a mismatch, back up to the previous partial match and see if the match can continue from there. If not, repeat until we find a match or hit the beginning"
		[partialMatch > 1 and: [(self at: partialMatch) ~= current]]
			whileTrue: [partialMatch := backtrack at: partialMatch - 1].

		(self at: partialMatch) = current
			ifTrue: [partialMatch := partialMatch + 1].
		backtrack at: index put: partialMatch].

	^backtrack
