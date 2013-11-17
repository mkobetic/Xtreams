"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - interpreting
"
testInterpretingDoubles
	| doubles result |
	doubles := (1 to: 10) reading collect: [ :i | i reciprocal asDouble ].
	(self output interpreting: #double) write: doubles; close.
	result := (self input interpreting: #double) rest.
	self assert: result = doubles asArray
