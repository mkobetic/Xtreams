"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
fillBuffer: anInteger
"
	We have exhausted our buffer, so fill it up again from our inner stream. Do not read more than is available from the inner stream or more than was originally requested. But try to be as greedy as possible, since filling our buffer is faster than always re-filling our buffer with one object at a time. Also, cap it at @bufferSize, because if we're reading from in-memory or on-disk sources, all the data will be immediately available - which could be gigs worth. We don't want to pull all of that in to our buffer.
	The semantics of our block are interesting. We give it both an input and an output stream. The block must write something to the output stream otherwise we assume this means we're at the end of the stream. It does not need to read from the input stream, but if it does and that stream fires EndOfStream, that also marks us as end of stream.
"
	| count available |
	count := 0.
	[[available := buffer readSize.
	block value: source value: bufferWriting.
	count := count + (buffer readSize - available).
	count >= anInteger ifTrue: [^self].
	buffer hasSpaceToWrite ifFalse: [^self]]
		repeat]
			on: Incomplete do: [:ex | ^sourceAtEnd := true].