*Xtreams-Transforms-private
nextPut: anObject
	"This is here for compatibility with the existing StreamEncoders so that they can be re-used with transformation streams for encoding."
	self put: anObject.
	^anObject