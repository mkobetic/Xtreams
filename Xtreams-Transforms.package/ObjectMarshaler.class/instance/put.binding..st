"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: writing - complex
"
put: writing binding: aBinding
	<writes: 'Core.VariableBinding'>

	self marshal: writing object: aBinding environment residesInStandardEnvironment.
	aBinding environment residesInStandardEnvironment
		ifTrue: [^self put: writing string: aBinding absoluteName].

	self put: writing string: aBinding key.
	self marshal: writing object: aBinding value.
	self marshal: writing object: aBinding environment.