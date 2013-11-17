"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testOrderedCollection
	| result |
	marshaling put: (OrderedCollection new add: #test; add: 'test'; add: 5; yourself).
	self analyse.
	result := marshaling get.
	self assert: result first = #test.
	self assert: (result at: 2) = 'test'.
	self assert: result last = 5
