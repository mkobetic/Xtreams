"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: initialize-release
"
on: aSource marshaler: aMarshaler
	super on: aSource.
	marshaler := aMarshaler.
	nothing := Object new.
	objects := OrderedCollection with: Transcript.
	depth := 0.

	log := String new writing.
	int_8 := aSource interpreting: #signedChar.
	(self log: 'header' do: [marshaler configureAnalyse: aSource])
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
