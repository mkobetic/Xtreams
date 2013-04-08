"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testBuffered
	| writing count |
	count := 0.
	writing := [:o | count := count + 1] writing buffering: 10.
	writing write: #[1 2 3 4 5].
	self assert: count = 0.
	writing write: #[6 7 8 9].
	self assert: count = 0.
	writing put: 10.
	self assert: count = 0.
	writing write: #[11 12].
	self assert: count = 10.
	writing flush.
	self assert: count = 12.
	writing write: #[13 14].
	self assert: count = 12.
	writing close.
	self assert: count = 14