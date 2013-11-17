"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testDictionary
	| result |
	marshaling put: (Dictionary new at: 1 put: 'one'; at: #two put: 2; at: 'three' put: (4 @ 5); yourself).
	self analyse.
	result := marshaling get.
	self assert: (result at: 1) = 'one'.
	self assert: (result at: #two) = 2.
	self assert: (result at: 'three') = (4 @ 5)
