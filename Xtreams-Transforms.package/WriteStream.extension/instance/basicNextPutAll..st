*Xtreams-Transforms-private
basicNextPutAll: aString
	"This has to be tricky: Squeak TextConverter will encode a Character into Character rather than anInteger..."
	aString do: [:aCharacter | self put: aCharacter asciiValue].
	^aString