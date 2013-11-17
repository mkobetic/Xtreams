"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - core - positioning
"
testReadPositioningSeek

	| record in |
	record := #[ 1 2 3 4 5 6 7 8 9 0 ].
	self output write: record; close.
	in := self input positioning.
	self assert: (in ++ 7) = 7.
	self assert: in position = 7.
	self assert: (in -- 3) = 3.
	self assert: in position = 4.
	self assert: ([ in ++ record size ] on: Incomplete do: [:ex | ex count]) = (record size - 4).
