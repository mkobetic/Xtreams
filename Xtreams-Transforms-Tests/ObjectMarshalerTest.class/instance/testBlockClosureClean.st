"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testBlockClosureClean
	marshaling put: [].
	marshaling put: [:x :y | x + y].
	self analyse.
	self assert: marshaling get value = nil.
	self assert: (marshaling get value: 2 value: 3) = 5
