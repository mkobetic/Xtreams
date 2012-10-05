recycling
new: anInteger class: aClass
	anInteger == 1 ifTrue: [^objectspace1 new: anInteger class: aClass].
	anInteger == cacheSize ifTrue: [^objectspaceN new: anInteger class: aClass].
	^aClass withSize: anInteger