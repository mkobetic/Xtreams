"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: recycling
"
newInFixedSpace: anInteger class: aClass
	anInteger == 1 ifTrue: [^fixedspace1 newInFixedSpace: anInteger class: aClass].
	anInteger == cacheSize ifTrue: [^fixedspaceN newInFixedSpace: anInteger class: aClass].
	^aClass newInFixedSpace: anInteger
