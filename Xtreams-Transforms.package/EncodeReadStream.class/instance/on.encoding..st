initialize-release
on: aSource encoding: anEncoding

	super on: aSource.
	encoder := XTEncoder for: anEncoding.
	buffer := XTRingBuffer new: DefaultBufferSize class: ByteArray.
	bufferReading := buffer reading.
	bufferWriting := buffer writing.
	transparent := false.
	crPreceeding := false.