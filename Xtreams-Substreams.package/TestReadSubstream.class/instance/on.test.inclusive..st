"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aSource test: testBlock inclusive: aBoolean
	self on: aSource.
	test := testBlock.
	inclusive := aBoolean.
	substreamAtEnd := false
