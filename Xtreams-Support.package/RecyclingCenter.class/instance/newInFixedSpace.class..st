"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: recycling
"
newInFixedSpace: anInteger class: aClass
	| collection |
	(collection := self existing: aClass) == nil ifTrue: [collection := aClass newInFixedSpace: anInteger].
	^collection
