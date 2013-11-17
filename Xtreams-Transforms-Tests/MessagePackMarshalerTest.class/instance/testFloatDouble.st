"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testFloatDouble
	marshaling write: #(3.14 3.14159 3.141592653589793).
	self analyse.
	self assert: marshaling rest = #(3.14 3.14159 3.141592653589793)
