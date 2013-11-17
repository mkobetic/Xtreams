"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: writing - complex
"
put: writing binding: aBinding
	<writes: 'Core.VariableBinding'>

	self marshal: writing object: aBinding environment isInStandardEnvironment.
	aBinding environment isInStandardEnvironment
		ifTrue: [^self put: writing string: aBinding absoluteName].

	self put: writing string: aBinding key.
	self marshal: writing object: aBinding value.
	self marshal: writing object: aBinding environment.
