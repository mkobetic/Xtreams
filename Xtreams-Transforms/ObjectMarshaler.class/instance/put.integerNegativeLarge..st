"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: writing - numbers
"
put: writing integerNegativeLarge: integer
	self put: writing byte: 255.
	self put: writing integerLarge: integer negated
