"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - core
"
testWriteCollection

	| data |
	data := #[1 2 3 4 5 6 7].
	self assert: (self output write: data) = data size.
	self assert: (self input read: data size) = data
