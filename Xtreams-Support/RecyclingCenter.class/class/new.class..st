"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: recycling
"
new: anInteger class: aClass
	anInteger == 1 ifTrue: [^objectspace1 new: anInteger class: aClass].
	anInteger == cacheSize ifTrue: [^objectspaceN new: anInteger class: aClass].
	^aClass withSize: anInteger
