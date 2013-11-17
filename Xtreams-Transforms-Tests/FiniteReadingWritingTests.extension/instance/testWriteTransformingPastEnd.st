"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
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
