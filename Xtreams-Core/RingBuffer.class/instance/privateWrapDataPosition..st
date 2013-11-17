"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
privateWrapDataPosition: anInteger
"       inflatedLength <= cache size --- do nothing
	inflatedLength >   cache size --- move dataPosition and readPosition
"
	| inflatedLength overflow |

	inflatedLength := writePosition + anInteger.
	inflatedLength <= cache size ifTrue: [^self].
	overflow := inflatedLength - cache size.
	readPosition := (readPosition - overflow) max: 0.
	dataPosition := (dataPosition + overflow) \\ cache size
