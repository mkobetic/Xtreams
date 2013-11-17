"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: analyse - complex
"
analyse: reading namespace: aClass
	<analyse: 'Kernel.NameSpace'>

	| namespace |
	^reading log: ['namespace: ', namespace absoluteName] do: [namespace := (self get: reading string: String) asStrictReference value]
