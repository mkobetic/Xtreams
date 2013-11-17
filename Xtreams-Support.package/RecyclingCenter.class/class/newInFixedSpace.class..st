"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: recycling
"
newInFixedSpace: anInteger class: aClass
	anInteger == 1 ifTrue: [^fixedspace1 newInFixedSpace: anInteger class: aClass].
	anInteger == cacheSize ifTrue: [^fixedspaceN newInFixedSpace: anInteger class: aClass].
	^aClass newInFixedSpace: anInteger
