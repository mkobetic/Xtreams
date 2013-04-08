"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: line-end
"
setLineEndCRLF

	| stream |
	decodedLineEnd := Character cr.
	stream := ByteArray new writing.
	encoder encode: Character cr on: stream; encode: Character lf on: stream.
	encodedLineEnd := stream contents