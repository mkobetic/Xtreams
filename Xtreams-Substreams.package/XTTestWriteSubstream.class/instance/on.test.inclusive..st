initialize-release
on: aDestination test: testBlock inclusive: aBoolean
	self on: aDestination.
	test := testBlock.
	inclusive := aBoolean.
	substreamAtEnd := false