"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - core
"
testWriteFromStream
	| data |
	data := #[ 1 2 3 4 ] reading.
	self assert: (self output write: 3 from: data) = 3.
	self assert: (self output write: 1 from: data) = 1.
	self assert: (self input read: 3) = #[ 1 2 3 ].
	self assert: self input get = 4.
	self assert: (
		[	self output write: 2 from: data. false
		] on: Incomplete do: [ :eos |
			eos count = 0 ])
