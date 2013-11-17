"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
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
