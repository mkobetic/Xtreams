"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
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
			int16 := aDestination interpreting: #signedShort_be.
			int32 := aDestination interpreting: #signedLong_be.
			int64 := aDestination interpreting: #signedLonglong_be.
			uint16 := aDestination interpreting: #unsignedShort_be.
			uint32 := aDestination interpreting: #unsignedLong_be.
			uint64 := aDestination interpreting: #unsignedLonglong_be]
		ifFalse: [
			int16 := aDestination interpreting: #signedShort_le.
			int32 := aDestination interpreting: #signedLong_le.
			int64 := aDestination interpreting: #signedLonglong_le.
			uint16 := aDestination interpreting: #unsignedShort_le.
			uint32 := aDestination interpreting: #unsignedLong_le.
			uint64 := aDestination interpreting: #unsignedLonglong_le].
	float := aDestination interpreting: #float.
	double := aDestination interpreting: #double