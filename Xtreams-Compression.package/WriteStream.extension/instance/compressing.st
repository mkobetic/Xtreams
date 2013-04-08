"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: transforming
"
compressing
	"Compresses the bytes being written using the ZLib deflate compression method. The compressed content is written into the binary destination stream. The compression algorithm buffers the content being compressed, consequently the stream must be closed in order to ensure that the entire compressed content was written into the destination stream.
	""	^	<CompressWriteStream>
	""
		| compressed |
		compressed := (ByteArray new writing compressing encoding: #ascii) write: 'Hello World!'; conclusion.
		(compressed reading compressing encoding: #ascii) rest.
	"

	^CompressWriteStream on: self