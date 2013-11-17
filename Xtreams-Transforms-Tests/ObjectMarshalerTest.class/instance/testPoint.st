"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testPoint
	marshaling put: -1 @ 2.
	marshaling put: 3.4 @ -4.5.
	marshaling put: 5 @ 5.
	self analyse.
	self assert: marshaling get = (-1 @ 2).
	self assert: marshaling get = (3.4 @ -4.5).
	self assert: marshaling get = (5 @ 5)
