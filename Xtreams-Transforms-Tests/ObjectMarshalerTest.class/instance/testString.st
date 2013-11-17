"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testString
	marshaling put: 'testing Î©'.
	self analyse.
	self assert: marshaling get = 'testing Î©'
