"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: reading - complex
"
get: reading point: aClass
	<reads: 'Core.Point'>

	^Point
		x: (self unmarshal: reading) 
		y: (self unmarshal: reading)
