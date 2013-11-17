"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testArray
	marshaling put: (Array with: 1 with: -2.7 with: true).
	self analyse.
	self assert: marshaling get = (Array with: 1 with: -2.7 with: true)
