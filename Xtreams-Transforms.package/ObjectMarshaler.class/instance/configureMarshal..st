"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: configuration
"
configureMarshal: writing
	"Negotiate this marshaler on the writing stream and return true if the stream should be big-endian."

	writing
		write: version;
		put: InterpretedBytes isBigEndian coerceToCInteger;
		flush.
	^InterpretedBytes isBigEndian
