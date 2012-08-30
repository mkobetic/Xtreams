line-end
setLineEndCRLF

	| stream |
	decodedLineEnd := Character cr.
	stream := ByteArray new writing.
	encoder encode: Character cr on: stream; encode: Character lf on: stream.
	encodedLineEnd := stream contents