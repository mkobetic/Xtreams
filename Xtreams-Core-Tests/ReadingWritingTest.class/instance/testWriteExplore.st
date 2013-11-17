"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
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
