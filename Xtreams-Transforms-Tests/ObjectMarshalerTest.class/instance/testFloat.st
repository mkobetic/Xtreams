"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testFloat
	marshaling put: 5.4.
	marshaling put: -172.11102.
	self analyse.
	self assert: marshaling get = 5.4.
	self assert: marshaling get = -172.11102
