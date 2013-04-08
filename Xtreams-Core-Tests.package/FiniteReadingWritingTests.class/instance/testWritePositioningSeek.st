"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - core - positioning
"
testWritePositioningSeek

	| record out |
	record := #[ 1 2 3 4 5 6 7 8 9 0 ].
	out := self output positioning.
	out	write: record.
	self assert: (out -- 7) = 7.
	self assert: out position = 3.
	self assert: (out ++ 3) = 3.
	self assert: out position = 6.
	self assert: ([ out ++ record size ] on: Incomplete do: [:ex | ex count]) = (record size - 6).
	out close.
	self assert: (self input read: record size) = record