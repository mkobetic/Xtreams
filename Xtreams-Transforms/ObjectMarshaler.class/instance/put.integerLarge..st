"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: writing - numbers
"
put: writing integerLarge: integer
	| printed |
	printed := String new writeStream.
	integer printOn: printed base: 36.
	printed := printed contents.
	printed size > 9223372036854775808 ifTrue: [self error: 'this number is too big for me, try again in a thousand years.'].
	self put: writing string: printed
