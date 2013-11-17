"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: writing - numbers
"
put: writing integer: integer
	<writes: 'Core.Integer'>
	<writes: 'Core.SmallInteger'>
	<writes: 'Core.LargePositiveInteger'>
	<writes: 'Core.LargeNegativeInteger'>

	(integer between: 0 and: 251) ifTrue: [^self put: writing byte: integer].
	(integer between: -2147483647 and: 2147483648) ifTrue: [^self put: writing integerSmall: integer].
	(integer between: -9223372036854775807 and: 9223372036854775808) ifTrue: [^self put: writing integerMedium: integer].
	integer positive
		ifTrue:	[self put: writing integerPositiveLarge: integer]
		ifFalse:	[self put: writing integerNegativeLarge: integer]
