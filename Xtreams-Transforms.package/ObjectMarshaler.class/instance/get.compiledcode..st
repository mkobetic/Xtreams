"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: reading - complex
"
get: reading compiledcode: aClass
	<reads: 'Kernel.CompiledCode'>

	| object variableSize |
	aClass isVariable
		ifTrue:
			[variableSize := self get: reading integer: nil.
			object := aClass basicNew: variableSize]
		ifFalse:
			[variableSize := 0.
			object := aClass basicNew].

	1 to: aClass instSize do: [:index | object instVarAt: index put: (self unmarshal: reading)].
	1 to: variableSize do: [:index | object basicAt: index put: (self unmarshal: reading)].
	^object