"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: analyse - complex
"
analyse: reading binding: aClass
	<analyse: 'Core.VariableBinding'>

	| binding isInStandardEnvironment |
	reading
		log: ['binding: ', binding]
		do: [isInStandardEnvironment := self unmarshal: reading.
			binding := self get: reading string: String.
			isInStandardEnvironment ifFalse:
				[reading log: 'value' do: [self analyse: reading].
				reading log: 'environment' do: [self analyse: reading]]]
