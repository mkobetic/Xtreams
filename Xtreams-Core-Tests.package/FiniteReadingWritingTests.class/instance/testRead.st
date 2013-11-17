"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - core
"
testRead

	self output write: #[ 1 2 3 4 ]; close.
	self assert: (self input read: 3) = #[1 2 3].
	self assert: ([self input read: 2. false] on: Incomplete do: [:exception |
		exception collection first = 4.
		exception collection size = 2.
		exception count = 1.
		true])
