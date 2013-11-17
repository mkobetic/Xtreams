"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
setUp

	buffer := RingBuffer on: (ByteArray new: 8192).
	input := buffer reading.
	output := buffer writing.
