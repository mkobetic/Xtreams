"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
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