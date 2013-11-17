"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: initialize-release
"
on: aSource test: testBlock inclusive: aBoolean
	self on: aSource.
	test := testBlock.
	inclusive := aBoolean.
	substreamAtEnd := false
