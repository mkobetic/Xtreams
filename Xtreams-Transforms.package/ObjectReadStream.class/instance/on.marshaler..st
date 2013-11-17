"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aSource marshaler: aMarshaler
	super on: aSource.
	marshaler := aMarshaler.
	objects := Array with: false with: Transcript.
	nothing := Object new.

	int_8 := aSource interpreting: #signedChar.
	(marshaler configureUnmarshal: aSource)
		ifTrue: [
			int_16 := aSource interpreting: #signedShort_be.
			int_32 := aSource interpreting: #signedLong_be.
			int_64 := aSource interpreting: #signedLonglong_be.
			uint_16 := aSource interpreting: #unsignedShort_be.
			uint_32 := aSource interpreting: #unsignedLong_be.
			uint_64 := aSource interpreting: #unsignedLonglong_be]
		ifFalse: [
			int_16 := aSource interpreting: #signedShort_le.
			int_32 := aSource interpreting: #signedLong_le.
			int_64 := aSource interpreting: #signedLonglong_le.
			uint_16 := aSource interpreting: #unsignedShort_le.
			uint_32 := aSource interpreting: #unsignedLong_le.
			uint_64 := aSource interpreting: #unsignedLonglong_le].
	float_ := aSource interpreting: #float.
	double_ := aSource interpreting: #double