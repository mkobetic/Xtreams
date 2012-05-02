seeking
+= anInteger
	"Seek from the start of the stream by anInteger elements. The stream must be positionable."
	"	anInteger	<Integer>	The number of elements to go forward by."
	"
		String new writing write: 'Hello Would'; += 6; write: 'World'; close; destination
	"
	^self position: anInteger