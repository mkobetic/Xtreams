"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testInterval
	marshaling put: (1 to: 12 by: 2).
	self analyse.
	self assert: marshaling get = (1 to: 11 by: 2)
