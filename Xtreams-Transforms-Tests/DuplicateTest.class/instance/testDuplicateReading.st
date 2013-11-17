"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testDuplicateReading
	| copy |
	copy := Array new writing.
	self assert: (((0 to: 255) reading duplicating: copy) rest isSameSequenceAs: copy conclusion)
