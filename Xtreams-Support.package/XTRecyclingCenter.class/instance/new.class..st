recycling
new: anInteger class: aClass
	| collection |
	(collection := self existing: aClass) == nil ifTrue: [collection := aClass withSize: anInteger].
	^collection