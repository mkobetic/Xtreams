"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: printing
"
printOn: aStream 

	| printSize |
	printSize := self size.
	printSize > 50
		ifTrue: [printSize := 50].
	aStream nextPutAll: '#['.
	(1 to: printSize)
		do: [:index | (self at: index) printOn: aStream]
		separatedBy: [aStream space].
	printSize < self size ifTrue: [aStream nextPutAll: (#etc << #dialogs >> '...etc...') asString].
	aStream nextPut: $]