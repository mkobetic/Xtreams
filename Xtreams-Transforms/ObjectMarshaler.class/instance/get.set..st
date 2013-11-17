"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: reading - complex
"
get: reading set: aClass
	<reads: 'Core.Set'>

	| set size |
	size := self get: reading integer: nil.
	set := aClass new: size.
	size timesRepeat: [set add: (self unmarshal: reading)].
	^set
