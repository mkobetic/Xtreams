"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: reading - complex
"
get: reading linkedlist: aClass
	<reads: 'Core.LinkedList'>

	| collection size |
	size := self get: reading integer: nil.
	collection := aClass new.
	1 to: size do: [:index | collection add: (self unmarshal: reading)].
	^collection
