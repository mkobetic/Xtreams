*Xtreams-Transforms-private
basicNextPut: aCharacter
	"This has to be tricky: Squeak TextConverter will encode a Character into Character rather than anInteger..."
	self put: aCharacter asciiValue .
	^aCharacter