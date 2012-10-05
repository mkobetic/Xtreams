seeking
available
	"Return the number of elements available. The stream must be positionable."
	"	^	<Integer>	the number of elements available"
	"
		'Hello' reading ++2; available
	"
	^self length - self position