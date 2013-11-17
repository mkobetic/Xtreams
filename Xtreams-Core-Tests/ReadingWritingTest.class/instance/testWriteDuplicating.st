"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - transforming
"
testWriteDuplicating

	| original copy contents |
	contents := Array withAll: (0 to: 15).
	original := Array new writing.
	copy := Array new writing.
	(original duplicating: copy) write: contents.
	self assert: original conclusion = contents.
	self assert: copy conclusion = contents
