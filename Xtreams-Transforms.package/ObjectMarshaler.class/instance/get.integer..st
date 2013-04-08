"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: reading - numbers
"
get: reading integer: aClass
	<reads: 'Core.Integer'>
	<reads: 'Core.SmallInteger'>
	<reads: 'Core.LargePositiveInteger'>
	<reads: 'Core.LargeNegativeInteger'>

	| indicator |
	indicator := self get: reading byte: nil.
	indicator < 252 ifTrue: [^indicator].
	indicator = 252 ifTrue: [^self get: reading integerSmall: aClass].
	indicator = 253 ifTrue: [^self get: reading integerMedium: aClass].
	indicator = 254 ifTrue: [^self get: reading integerLarge: aClass].
	indicator = 255 ifTrue: [^(self get: reading integerLarge: aClass) negated]