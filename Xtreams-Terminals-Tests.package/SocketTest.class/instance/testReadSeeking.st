"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: testing
"
testReadSeeking

	| in |
	output writing put: 42; flush; close.
	in := input reading.
	self deny: in atEnd.
	self assert: in peek = 42.
	self assert: in peek = 42.
	self deny: in atEnd.
	self assert: in get = 42.
	self assert: in atEnd.
	self should: [ in peek ] raise: Incomplete