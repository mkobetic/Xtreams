"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: configuration
"
configureMarshal: writing
	"Negotiate this marshaler on the writing stream and return true if the stream should be big-endian."

	writing
		write: version;
		put: InterpretedBytes isBigEndian coerceToCInteger;
		flush.
	^InterpretedBytes isBigEndian
