"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - substream stitching
"
testReadStitchLimiting
"Note that a plain [ self input limiting: 3 ] reading stitching stream would never end because it keeps generating empty limiting: streams at the end of the input.
That's why additional measure is necessary to make sure the slice source eventually generates Incomplete.
" 
	| limiter wasEmpty |
	self output write: #[ 1 1 1 2 2 2 ]; close.
	wasEmpty := false.
	limiter := [
			wasEmpty ifTrue: [ Incomplete zero raise ]. wasEmpty := true.
			(self input doing: [ :e | wasEmpty := false ]) limiting: 3
		] reading stitching.

	self assert: limiter rest = #[ 1 1 1 2 2 2].
	self should: [limiter get] raise: Incomplete