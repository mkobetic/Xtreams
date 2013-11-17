"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
+= anInteger
	"Seek from the start of the stream by anInteger elements. The stream must be positionable."
	"       anInteger       <Integer>       The number of elements to go forward by."
	"
		'Hello' reading rest; += 2; rest
	"
	^self position: anInteger
