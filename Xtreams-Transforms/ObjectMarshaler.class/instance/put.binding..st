"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
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
