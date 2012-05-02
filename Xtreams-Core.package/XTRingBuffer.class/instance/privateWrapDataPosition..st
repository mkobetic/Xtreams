private
privateWrapDataPosition: anInteger
"	inflatedLength <= cache size --- do nothing
	inflatedLength >   cache size --- move dataPosition and readPosition
"
	| inflatedLength overflow |

	inflatedLength := writePosition + anInteger.
	inflatedLength <= cache size ifTrue: [^self].
	overflow := inflatedLength - cache size.
	readPosition := (readPosition - overflow) max: 0.
	dataPosition := (dataPosition + overflow) \\ cache size