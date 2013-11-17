"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - core
"
testWriteFromStream
	| data |
	data := #[ 1 2 3 4 ] reading.
	self assert: (self output write: 3 from: data) = 3.
	self assert: (self input read: 3) = #[ 1 2 3 ].
	self assert: (self output write: 1 from: data) = 1.
	self assert: self input get = 4.
	self assert: (
		[       self output write: 2 from: data. false
		] on: Incomplete do: [ :eos |
			eos count = 0 ])
