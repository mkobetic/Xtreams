"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: analyse - numbers
"
analyse: reading integer: aClass
	<analyse: 'Core.Integer'>
	<analyse: 'Core.SmallInteger'>
	<analyse: 'Core.LargePositiveInteger'>
	<analyse: 'Core.LargeNegativeInteger'>

	| indicator integer |
	integer := nil.
	reading log: [integer ifNil: ['integer'] ifNotNil: ['byte integer: ', integer printString]] do: [
		indicator := self get: reading byte: nil.
		indicator < 252 ifTrue: [integer := indicator. ^indicator].
		indicator = 255 ifTrue: [^self analyse: reading integerNegativeLarge: aClass].
		indicator = 254 ifTrue: [^self analyse: reading integerPositiveLarge: aClass].
		indicator = 253 ifTrue: [^self analyse: reading integerMedium: aClass].
		indicator = 252 ifTrue: [^self analyse: reading integerSmall: aClass]]
