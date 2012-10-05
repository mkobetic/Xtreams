*Xtreams-TransformsTests-transforming
testWriteDuplicating

	| original copy contents |
	contents := Array withAll: (0 to: 15).
	original := Array new writing.
	copy := Array new writing.
	(original duplicating: copy) write: contents.
	self assert: original conclusion = contents.
	self assert: copy conclusion = contents