"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: actions
"
putCharacter: aCharacter
	<action: #{Core.Character}>

	destination write: '"'.
	(self isEscaped: aCharacter)
		ifTrue: [ self putEscapedCharacter: aCharacter ]
		ifFalse: [ destination put: aCharacter ].
	destination write: '"'