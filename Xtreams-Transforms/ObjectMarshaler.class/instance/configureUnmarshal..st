"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: configuration
"
configureUnmarshal: reading
	"Negotiate this marshaler on the reading stream and return true if the stream should be big-endian."

	(reading read: version size) = version ifFalse: [self error: 'incompatible marshalers'].
	^reading get = true coerceToCInteger
