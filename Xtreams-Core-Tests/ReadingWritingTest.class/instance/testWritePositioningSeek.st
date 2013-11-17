"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - core - positioning
"
testWritePositioningSeek

	| record out |
	record := #[ 1 2 3 4 5 6 7 8 9 0 ].
	out := self output positioning.
	out     write: record.
	self assert: (out -- 7) = 7.
	self assert: out position = 3.
	self assert: (out ++ 3) = 3.
	self assert: out position = 6.
	self assert: (out ++ 4) = 4.
	out close.
	self assert: (self input read: record size) = record
