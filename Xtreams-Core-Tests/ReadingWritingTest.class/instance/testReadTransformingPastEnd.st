"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - transforming
"
testReadTransformingPastEnd
	| count transformed |
	count := 1.
	self output write: #[ 1 2 3 ]; close.
	transformed := self input transforming: [:in :out |
		count = 2 ifTrue: [Incomplete zero raise].
		out put: in get.
		count := count + 1].
	self assert: transformed get = 1.
	self should: [transformed get] raise: Incomplete.
	self should: [transformed get] raise: Incomplete