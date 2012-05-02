initialize-release
setUp

	buffer := XTRingBuffer on: (ByteArray new: 8192).
	input := buffer reading.
	output := buffer writing.