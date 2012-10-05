tests - seeking
testReadPositioningSeekFrom

	| record in |
	record := #[ 1 2 3 4 5 6 7 8 9 0 ].
	self output write: record; close.
	in := self input positioning. 
	self assert: (in += 3) = 3.
	self assert: in position = 3.
	self assert: (in -= 4) = 4.
	self assert: in position = 6.
	self assert: ([ in -= (record size + 6) ] on: Incomplete do: [:ex | ex count]) = record size.
	self assert: in position = 0.
	self assert: ([ in += (record size + 6) ] on: Incomplete do: [:ex | ex count]) = record size.
	self assert: in position = record size.