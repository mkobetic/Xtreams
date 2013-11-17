"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testBlockClosureDirty
	| a a_original a_copy |
	a := 1.
	a_original := [a].
	marshaling put: a_original.
	self analyse.
	a_copy := marshaling get.
	self assert: a_original value = 1.
	self assert: a_copy value = 1.
	a := 2.
	self assert: a_original value = 2.
	self assert: a_copy value = 1
