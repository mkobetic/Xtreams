"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aDestination test: testBlock inclusive: aBoolean
	self on: aDestination.
	test := testBlock.
	inclusive := aBoolean.
	substreamAtEnd := false