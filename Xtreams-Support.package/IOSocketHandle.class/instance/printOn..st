printing
printOn: aStream

	super printOn: aStream.
	socketType ifNotNil: [aStream nextPutAll: (' for ', socketType)].
"	aStream nextPutAll: ' ('.
	self handle inject: true into: [
		:first :e | 
		first ifFalse: [ aStream nextPut: Character space ].
		e printOn: aStream.
		false ].
	aStream nextPutAll: ')'"

