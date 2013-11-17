"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: initialize-release
"
setUp

	buffer := RingBuffer on: (ByteArray new: 8192).
	input := buffer reading.
	output := buffer writing.
