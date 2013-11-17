"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: analyse - complex
"
analyse: reading point: aClass
	<analyse: 'Core.Point'>

	reading log: 'point' do:
		[reading log: 'x:' do: [self analyse: reading].
		reading log: 'y:' do: [self analyse: reading]]
