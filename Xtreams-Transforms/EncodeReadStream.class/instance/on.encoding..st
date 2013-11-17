"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: initialize-release
"
on: aSource encoding: anEncoding

	super on: aSource.
	encoder := Encoder for: anEncoding.
	buffer := RingBuffer new: DefaultBufferSize class: ByteArray.
	bufferReading := buffer reading.
	bufferWriting := buffer writing.
	transparent := false.
	crPreceeding := false.
