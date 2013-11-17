"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
nextPut: anObject
	"This is here for compatibility with the existing StreamEncoders so that they can be re-used with transformation streams for encoding."
	self put: anObject.
	^anObject
