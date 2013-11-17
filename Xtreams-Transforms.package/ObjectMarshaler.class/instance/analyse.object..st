"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: analyse - complex
"
analyse: reading object: aClass
	<analyse: 'Core.Object'>

	reading log: 'object: ', aClass fullName do: [
		| variableSize allInstVarNames |
		variableSize := aClass isVariable
			ifTrue:	[self get: reading integer: nil]
			ifFalse:	[0].

		allInstVarNames := aClass allInstVarNames.
		1 to: aClass instSize do: [:index | reading log: (allInstVarNames at: index) do: [self analyse: reading]].
		1 to: variableSize do: [:index | reading log: index printString do: [self analyse: reading]]]
