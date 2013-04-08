"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: configuration
"
configureUnmarshal: reading
	encoding := ((reading encoding: #ascii) ending: Character cr) rest asSymbol.
	^false