"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aSource marshaler: aMarshaler
	super on: aSource.
	marshaler := aMarshaler.
	objects := Array with: false with: Transcript.
	nothing := Object new.

	int8 := aSource interpreting: #signedChar.
	(marshaler configureUnmarshal: aSource)
		ifTrue: [
			int16 := aSource interpreting: #signedShort_be.
			int32 := aSource interpreting: #signedLong_be.
			int64 := aSource interpreting: #signedLonglong_be.
			uint16 := aSource interpreting: #unsignedShort_be.
			uint32 := aSource interpreting: #unsignedLong_be.
			uint64 := aSource interpreting: #unsignedLonglong_be]
		ifFalse: [
			int16 := aSource interpreting: #signedShort_le.
			int32 := aSource interpreting: #signedLong_le.
			int64 := aSource interpreting: #signedLonglong_le.
			uint16 := aSource interpreting: #unsignedShort_le.
			uint32 := aSource interpreting: #unsignedLong_le.
			uint64 := aSource interpreting: #unsignedLonglong_le].
	float := aSource interpreting: #float.
	double := aSource interpreting: #double