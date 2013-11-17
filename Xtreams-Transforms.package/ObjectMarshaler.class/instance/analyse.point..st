"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: analyse - complex
"
analyse: reading point: aClass
	<analyse: 'Core.Point'>

	reading log: 'point' do:
		[reading log: 'x:' do: [self analyse: reading].
		reading log: 'y:' do: [self analyse: reading]]
