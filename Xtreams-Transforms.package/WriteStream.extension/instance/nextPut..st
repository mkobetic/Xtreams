"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
nextPut: anObject
	"This is here for compatibility with the existing StreamEncoders so that they can be re-used with transformation streams for encoding."
	self put: anObject.
	^anObject