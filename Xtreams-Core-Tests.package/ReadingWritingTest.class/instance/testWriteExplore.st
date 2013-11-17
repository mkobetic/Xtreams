"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - core - positioning
"
testWriteExplore

	| record mark out |
	record := #[ 1 2 3 4 5 6 7 8 9 0 ].
	out := self output positioning.
	mark := out position.
	out
		write: 0;
		write: record;
		explore: [out += mark; write: record size];
		close.
	self assert: (self input read: record size + 1) = ((ByteArray with: record size), record)
