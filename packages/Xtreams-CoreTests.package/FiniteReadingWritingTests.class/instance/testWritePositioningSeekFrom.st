tests - seeking
testWritePositioningSeekFrom

	| record out |
	record := #[ 1 2 3 4 5 6 7 8 9 0 ].
	out := self output positioning.
	out	write: record.
	self assert: (out += 3) = 3.
	self assert: out position = 3.
	self assert: (out -= 4) = 4.
	self assert: out position = 6.
	self assert: ([ out -= (record size + 6) ] on: Incomplete do: [:ex | ex count]) = record size.
	self assert: out position = 0.
	self assert: ([ out += (record size + 6) ] on: Incomplete do: [:ex | ex count]) = record size.
	self assert: out position = record size.
	out close.
	self assert: (self input read: record size) = record