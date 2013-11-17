"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: analyse - complex
"
analyse: reading compiledcode: aClass
	<analyse: 'Kernel.CompiledCode'>

	reading log: 'compiled code: ', aClass fullName do: [
		| variableSize allInstVarNames |
		variableSize := aClass isVariable
			ifTrue:	[self get: reading integer: nil]
			ifFalse:	[0].

		allInstVarNames := aClass allInstVarNames.
		1 to: aClass instSize do: [:index | reading log: (allInstVarNames at: index) do: [self analyse: reading]].
		1 to: variableSize do: [:index | reading log: index printString do: [self analyse: reading]]]
