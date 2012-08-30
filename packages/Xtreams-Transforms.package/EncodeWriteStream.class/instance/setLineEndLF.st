line-end
setLineEndLF

	| stream |
	decodedLineEnd := Character cr.
	stream := ByteArray new writing.
	encoder encode: Character lf on: stream.
	encodedLineEnd := stream contents