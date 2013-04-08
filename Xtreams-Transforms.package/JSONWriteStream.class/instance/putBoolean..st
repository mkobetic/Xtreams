"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: actions
"
putBoolean: aBoolean
	<action: #{Core.True}>
	<action: #{Core.False}>

	destination write: (aBoolean ifTrue: ['true'] ifFalse: ['false'])