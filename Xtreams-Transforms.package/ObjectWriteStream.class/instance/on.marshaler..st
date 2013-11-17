"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aDestination marshaler: aMarshaler
	super on: aDestination.
	marshaler := aMarshaler.
	objects := Array with: Transcript.
	nothing := Object new.

	int8 := aDestination interpreting: #signedChar.
	(marshaler configureMarshal: aDestination)
		ifTrue: [
			int_16 := aDestination interpreting: #signedShort_be.
			int_32 := aDestination interpreting: #signedLong_be.
			int_64 := aDestination interpreting: #signedLonglong_be.
			uint_16 := aDestination interpreting: #unsignedShort_be.
			uint_32 := aDestination interpreting: #unsignedLong_be.
			uint_64 := aDestination interpreting: #unsignedLonglong_be]
		ifFalse: [
			int_16 := aDestination interpreting: #signedShort_le.
			int_32 := aDestination interpreting: #signedLong_le.
			int_64 := aDestination interpreting: #signedLonglong_le.
			uint_16 := aDestination interpreting: #unsignedShort_le.
			uint_32 := aDestination interpreting: #unsignedLong_le.
			uint_64 := aDestination interpreting: #unsignedLonglong_le].
	float_ := aDestination interpreting: #float.
	double_ := aDestination interpreting: #double
