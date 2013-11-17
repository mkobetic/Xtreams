"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: analyse - complex
"
analyse: reading namespace: aClass
	<analyse: 'Kernel.NameSpace'>

	| namespace |
	^reading log: ['namespace: ', namespace absoluteName] do: [namespace := (self get: reading string: String) asStrictReference value]
