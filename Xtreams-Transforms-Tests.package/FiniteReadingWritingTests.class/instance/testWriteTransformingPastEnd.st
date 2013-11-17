"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - transforming
"
testWriteTransformingPastEnd
	| count transformed |
	count := 1.
	transformed := self output transforming: [:in :out |
		count = 2 ifTrue: [Incomplete zero raise].
		out put: in get.
		count := count + 1].
	self assert: (
		[       transformed write: #[ 1 2 3 ].
			false
		] on: Incomplete do: [ :ex | ex count = 1 ]).
	transformed close.
	self assert: self input get = 1.
	self should: [self input get] raise: Incomplete.
	self should: [self input get] raise: Incomplete
