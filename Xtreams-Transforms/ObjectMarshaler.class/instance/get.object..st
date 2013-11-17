"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: reading - complex
"
get: reading object: aClass
	<reads: 'Core.Object'>

	| object variableSize |
	aClass isVariable
		ifTrue:
			[variableSize := self get: reading integer: nil.
			object := aClass withSize: variableSize]
		ifFalse:
			[variableSize := 0.
			object := aClass basicNew].

	1 to: aClass instSize do: [:index | object instVarAt: index put: (self unmarshal: reading)].
	1 to: variableSize do: [:index | object basicAt: index put: (self unmarshal: reading)].
	^object
