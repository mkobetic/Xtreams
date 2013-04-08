"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: analyse - complex
"
analyse: reading point: aClass
	<analyse: 'Core.Point'>

	reading log: 'point' do:
		[reading log: 'x:' do: [self analyse: reading].
		reading log: 'y:' do: [self analyse: reading]]