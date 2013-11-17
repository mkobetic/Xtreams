"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: reading - numbers
"
get: reading integerLarge: integer
	| printed |
	printed := self get: reading string: String.
	^Number readIntegerFrom: printed readStream radix: 36
