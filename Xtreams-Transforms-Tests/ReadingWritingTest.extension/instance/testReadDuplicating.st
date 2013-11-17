"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - transforming
"
testReadDuplicating

	| copy contents |
	contents := Array withAll: (0 to: 15).
	copy := Array new writing.
	self assert: (contents reading duplicating: copy) rest = contents.
	self assert: copy conclusion = contents
